class GetAiResponseJob < ApplicationJob
  queue_as :default
  def perform(script)
    if script.script_body.empty?
      prompt = "Create a 'technical script' for a YouTube video about #{script.topic}.
      The video should have a duration of around #{script.duration || '8'} minutes.
      Its tone should be #{script.tone || 'neutral'}.
      Create it by following this prompt: '#{script.blueprint.prompt_template}'
      Write it using only h4, h5, and p tags in HTML code but don't include the head tag."
    else
      prompt = "
      Rewrite the following 'technical script' for a YouTube video about #{script.topic}:
      '#{script.script_body}'
      Make sure the new version has a #{script.tone} tone, and the video made from this script should be #{script.duration} minutes long.
      Write it using only h4, h5, and p tags in HTML code but don't include the head tag."
    end
    call_openai(script, prompt)
  end

  private

  def call_openai(script, prompt)
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
          stream: stream_proc(script)
        }
      )
  end

  def stream_proc(script)
    proc do |chunk, _bytesize|
      new_content = chunk.dig('choices', 0, 'delta', 'content')

      if new_content
        script.update(script_body: script.script_body + new_content)
        # Broadcast updated message using ActionCable
        PostChannel.broadcast_to(script,
                                 ApplicationController.new.render_to_string(partial: 'scripts/script_body',
                                                                            locals: { script: }))
      end
    end
  end
end
