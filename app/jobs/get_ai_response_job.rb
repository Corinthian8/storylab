class GetAiResponseJob < ApplicationJob
  queue_as :default
  # instead of passing the prompt as is, we need to pass the Script instance and get the prom there
  def perform(script)
    # byebug
    if script.script_body.empty?
      prompt = "Create a 'technical script' for a YouTube video about #{script.topic}.
      The video should have a duration of around #{script.duration || '8'} minutes.
      Its tone should be #{script.tone || 'neutral'}.
      Create it by following this prompt: '#{script.blueprint.prompt_template}'"
    else
      prompt = "
      Rewrite the following 'technical script' for a YouTube video about #{script.topic}:
      '#{script.script_body}'
      Make sure the new version has a #{script.tone} tone, and the video made from this script should be #{script.duration} minutes long."
    end
    call_openai(script, prompt)
  end

  private

  def call_openai(script, prompt)
    # Instead of creating a message, we want to update the body of the Script instance
    # message = Message.create(role: 'assistant', content: 'Thinking...')
    # byebug
    script.update(script_body: '')
    puts prompt

    # Broadcast initial message using ActionCable

    OpenAI::Client
      .new(access_token: ENV['OPENAI_API_KEY'])
      .chat(
        parameters: {
          model: 'gpt-3.5-turbo',
          messages: [{ role: 'user', content: prompt }],
          temperature: 0.1,
          stream: proc do |chunk, _bytesize|
            new_content = chunk.dig('choices', 0, 'delta', 'content')
            puts new_content, '####################'
            # byebug
            if new_content
              script.update(script_body: script.script_body + new_content)
              # Broadcast updated message using ActionCable
              PostChannel.broadcast_to(script,
                                       ApplicationController.new.render_to_string(partial: 'scripts/script_body',
                                                                                  locals: { script: script }))
            end
          end
        }
      )
  end

  def stream_proc(script)
    proc do |chunk, _bytesize|
      new_content = chunk.dig('choices', 0, 'delta', 'content')
      puts new_content, '####################'

      if new_content
        script.update(script_body: script.script_body + new_content)
        # Broadcast updated message using ActionCable
        PostChannel.broadcast_to(script,
                                 ApplicationController.new.render_to_string(partial: 'scripts/script_body',
                                                                            locals: { script: }))
      end
    end
  end

  # def stream_proc(script)
  #   proc do |chunk, _bytesize|
  #     new_content = chunk.dig('choices', 0, 'delta', 'content')

  #     if new_content
  #       script.update(script_body: script.script_body + new_content)
  #       # Broadcast updated message using ActionCable
  #       PostChannel.broadcast_to (script,
  #         ApplicationController.new.render_to_string(partial: "script/script_body", locals: { script: script })
  #       # {
  #       #   partial: ApplicationController.new.render_to_string(partial: "messages/script", locals: {script: self}),
  #       #   script_id: self.id,
  #       #   update: true
  #       # }
  #       )
  #     end
  #   end
  # end

  # def render_message(message)
  #   ApplicationController.renderer.render(partial: 'messages/message', locals: { message: })
  # end
end
