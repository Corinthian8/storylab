# frozen_string_literal: true

require 'open-uri'

puts 'Cleaning database...'

Location.destroy_all
Script.destroy_all
User.destroy_all
Blueprint.destroy_all

puts 'Creating Users...'

puts 'Creating Test User...'

testuser = User.create!(
  email: 'test@storylab.com',
  password: '123456'
)

puts "User with id :#{testuser.id} has been created"

puts 'Creating Blueprints...'

comparison = Blueprint.create!(
  name: 'Comparison',
  prompt_template: %{
    "Please generate a detailed script comparing the features and specifications of the indicated items,
    highlighting the improvements and differences between them."
    },
  sample_videos: %w[vgZvlLkFeAs 8UKikrUZg7Q wmb5AmE4TUs],
  word_cloud: ["Valuable", "Informative", "Eye-opening", "Intriguing", "Speculative", "Captivating"],
  description: 'Visual analysis that contrasts and evaluates the similarities and differences between two or more subjects,
  often offering insights to help viewers make informed decisions.',
  sampleimage: 'Compare2.png'
)

puts "#{comparison.name} blueprint has been created"

commentary = Blueprint.create!(
  name: 'Commentary',
  prompt_template: 'Script a reaction video to the indicated topic. It should include initial impressions,
  emotional responses, and thoughtful commentary.',
  sample_videos: ['zIqR43D4CwI', 'uPX1ObBBt_U', 'exm5iJirkIo'],
  word_cloud: ["Humorous", "Opinionated", "Casual", "Free-flowing", "Instinctual", "Cheeky"],
  description: 'Provide real-time commentary and emotional responses while experiencing various forms of media content,
  often for entertainment or discussion purposes.',
  sampleimage: 'Podcast2.png'
)

puts "#{commentary.name} blueprint has been created"

no_experience = Blueprint.create!(
  name: 'I tried _____ with NO experience',
  prompt_template: "Script a video about attempting the indicated topic without having any prior experience.
  Make sure that the narrator covers the experience step by step, their impressions and emotional response.
  Please ensure it’s engaging and suitable for a diverse audience.
  The title of the video should be something like 'I attempted [topic] with NO experience', or
  'I went [topic] with NO experience'.",
  sample_videos: ['z2lcoeF0U_Y', 'sPsxnd-jKZE', 'ftwysv8-gx8'],
  word_cloud: ["Adventurous", "Crazy", "Risky", "Insane", "Wild", "Unfamiliar"],
  description: "Follow an individual's journey as they engage in an activity or task they are unfamiliar with,
  capturing their initial challenges, progress, and eventual outcomes.",
  sampleimage: 'Camp2.png'
)

puts "#{no_experience.name} blueprint has been created"

how_to_beat = Blueprint.create!(
  name: 'How to beat _____',
  prompt_template: "Script a video about how to overcome the indicated topic with details about each step.
  Make sure that the narrator gives sound advice and logic for overcoming the challenge.
  Please ensure it’s engaging and suitable for a diverse audience.
  The title of the video should be something like 'How to beat [topic]', or 'How you can beat [topic]'.",
  sample_videos: ['qNKA9Q60K10', 'Q12QqMhLa-Y', 'Iq9AiG4KDa4'],
  word_cloud: ["Triumphant", "Empowering", "Determined", "Proven", "Detailed", "Instructional"],
  description: "Offer your viewers a comprehensive and step-by-step strategy for addressing a specific challenge or obstacle.",
  sampleimage: 'videogame.png'
)

puts "#{how_to_beat.name} blueprint has been created"

is_it_possible = Blueprint.create!(
  name: 'Is it possible to _____ ?',
  prompt_template: "Script a video that delves into the question about whether or not
  it's possible to accomplish the indicated topic. Make sure that the narrator explores all possibilities
  related to achieving the desired outcome. Please ensure it’s engaging and suitable for a diverse audience.
  The title of the video should be something like 'Is it possible to do [topic]', or 'Is it possible to [topic]'.",
  sample_videos: ['AwPq-7BrzDo', 'QNV4gHWZ9p4', '5vZ4lCKv1ik'],
  word_cloud: ["Skeptical", "Feasible", "Speculative", "Viable", "Potential", "Uncertainty"],
  description: "Delve deep into the realm of making the impossible, possible.",
  sampleimage: 'Art2.png'
)

puts "#{is_it_possible.name} blueprint has been created"

i_only_did = Blueprint.create!(
  name: 'I only did _____ for 30 days',
  prompt_template: "Script a video in which the narrator attempts to do one indicated topic activity for the next 30 days.
  Make sure that the narrator details their experiences along the way. Please ensure it’s engaging and suitable for a diverse audience.
  The title of the video should be something like 'I only did [topic] for 30 days', or 'I tried only doing [topic] for 30 days'.",
  sample_videos: ['h2vAozPxvzU', 'O6UedmnRJc0', 'WLoLAdXpf7I'],
  word_cloud: ["Persistent", "Transformational", "Dedicated", "Adventurous", "Experimental", "Repetitive"],
  description: "Take the viewers on a journey to see what happens to you over the next 30 days.",
  sampleimage: 'Cycle2.png'
)

puts "#{i_only_did.name} blueprint has been created"

worlds_most = Blueprint.create!(
  name: "I traveled to the world's most _____ place",
  prompt_template: "Script a video in which the narrator travels to a location known to be the most extreme for the indicated topic.
  Make sure that the narrator details their travel experiences along the way. Please ensure it’s engaging and suitable for a diverse audience.
  The title of the video should be something like 'I traveled to the world's most [topic] country', or 'I traveled to the country known to be the most [topic]'.",
  sample_videos: ['hxC1NBfCECM', 'taXDBwLOWg8', 'JPPMz8fEml0'],
  word_cloud: ["Adventurous", "Unpredictable", "Unknown", "Challenging", "Life-changing", "Discovery"],
  description: "Show your audience what life is like in some of the most extreme travel destinations in the world.",
  sampleimage: 'Travel2.png'
)

puts "#{worlds_most.name} blueprint has been created"

puts 'Creating Scripts...'

pitch = Script.create!(
  name: "StoryLab's Pitch",
  user_id: testuser.id,
  blueprint_id: commentary.id,
  topic: 'Startup Pitch',
  script_body: "[Opening shot: A cheerful, colorful interface of the StoryLab web-app with the words \"Unleash Your Inner Creator!\" splashed across the screen.]\n
  Narrator (with excitement): Hey there, fellow content creators and aspiring YouTube stars! Are you tired of staring at a blank screen, struggling to come up with the perfect script for your next YouTube masterpiece? Well, fret not, because I'm about to introduce you to your new secret weapon: StoryLab!\n\n
  [Cut to index page: User's cursor hovers over a variety of template options, each with a catchy title.]\n
  Narrator: Picture this – you're all set to create an awesome YouTube video, but you're just not sure where to begin. That's where StoryLab comes in! With a smorgasbord of pre-designed templates, you'll be crafting compelling scripts faster than you can say \"subscribe and hit the bell icon\"!\n\n
  [Transition to a close-up of the user typing their chosen topic into the designated field.]\n
  Narrator: Let's get this creative party started! Step one: pick a template that tickles your fancy. We've got everything from \"How-To Extravaganza\" to \"Epic Vlog Adventure\"! It's like a buffet of scriptwriting brilliance!\n\n
  [Zoom out to reveal the user's script magically taking shape on the screen.]\n
  Narrator: Now that you've got your template locked and loaded, it's time to dive into your topic. Whether you're into cooking, gaming, fashion, or even extreme pogo-stick jumping (hey, no judgment), StoryLab's got your back!\n\n
  [Cut to a split-screen: On the left side, the user adjusts various parameters like tone, pacing, and style. On the right side, the script evolves accordingly.]\n
  Narrator: But wait, there's more! We're not just about templates – we're about tailoring them to fit your unique style. With a few clicks, you can tweak the tone, adjust the pacing, and sprinkle in your personal flair faster than you can say \"like, comment, and share\"!\n\n
  [Transition to a shot of the user previewing their script, accompanied by lively music.]\n
  Narrator: Now it's time for the moment of truth – the grand unveiling! Hit that preview button, and behold as your script comes to life in a dynamic, interactive storyboard. It's like watching your ideas do the cha-cha in real-time!\n\n
  [Cut to a shot of the user sharing their storyboard with a friend, both laughing and brainstorming.]\n
  Narrator: But wait, there's a cherry on top of this creativity sundae – collaboration! Share your storyboard with friends, family, or even your pet goldfish (they're great critics, trust me). It's a collaborative playground where ideas collide and magic happens!\n\n
  [Zoom out to show the user hitting the \"Export\" button and their script transforming into a beautifully formatted document.]\n
  Narrator: Congratulations, maestro! Your script is polished, perfected, and ready to rock the YouTube world. Hit that export button, and you'll be holding a script that even Shakespeare would give a standing ovation!\n\n
  [Cut to a shot of the user filming their video, surrounded by lights, cameras, and all the YouTube glory.]\n
  Narrator: So there you have it, folks – StoryLab, your ultimate wingman in the world of YouTube scripting. From template selection to topic input, and all the way to a masterpiece script, we've got your creative journey covered. So go ahead, dive in, and let your content-creating dreams run wild!\n\n
  [Closing shot: The StoryLab logo and tagline: \"Where Ideas Transform into Epic Stories!\"]\n
  Narrator (enthusiastically): Remember, with StoryLab, your story is just the beginning – the YouTube stage is yours to conquer! Get started today and unleash your inner creator. Happy scripting, and may your videos be forever viral!\n\n
  [The screen transitions to a behind-the-scenes scene, revealing the narrator sitting at a desk with a laptop displaying the StoryLab interface.]\n
  Narrator (with a wink): Oh, and before I forget – you know that playful pitch you just heard? Yep, you guessed it, it was whipped up using none other than StoryLab itself! See? It's not just a script creator; it's a storytelling magician!\n\n
  [The narrator raises their laptop screen, revealing the StoryLab logo once again.]\n
  Narrator: So go on, give it a whirl, and who knows, maybe your next pitch could be as captivating as this one! Thanks for tuning in, and remember, with StoryLab, your creative journey is just a click away. Cheers to your future YouTube stardom!\n\n
  [The screen fades out with the StoryLab logo and website link.]\n
  Narrator: Happy scripting!",
  tone: 'playful',
  duration: 3
)

testscript = Script.create!(
  name: 'TestScript',
  user_id: testuser.id,
  blueprint_id: comparison.id,
  topic: 'Test',
  script_body: 'Some text here generated with AI',
  tone: 'informative',
  duration: 10
)

puts "Script with id :#{testscript.id} has been created"

puts 'Finished!'
