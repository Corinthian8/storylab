class GenerateScriptJob < ApplicationJob
  queue_as :default

  def perform(script)
    script_body = generate_script(script)
    script.update(script_body: script_body)
  end

  private

  def generate_script(script)
    ChatgptService.call("Create a 'technical script' for a YouTube video about #{script.topic}.
      The video should have a duration of around #{script.duration || '8'} minutes.
      Its tone should be #{script.tone || 'neutral'}.
      Create it by following this prompt: '#{script.blueprint.prompt_template}'.")
  end
end
