# frozen_string_literal: true

require 'open-uri'

puts 'Cleaning database...'

Plan.destroy_all
Location.destroy_all
Script.destroy_all
User.destroy_all
Blueprint.destroy_all

puts 'Creating Blueprints...'

five_simple_steps = Blueprint.create!(
  name: "Learn how to _____ in 5 simple steps",
  prompt_template: "Script a video in which the narrator explains how to learn an indicated topic in five simple steps.
  Make sure that the narrator labels and details each step along the way. Please ensure it’s engaging and suitable for a diverse audience.
  The title of the video should be something like 'Learn how to [topic] in 5 easy steps', or 'Discover how to [topic] in 5 simple steps'.",
  sample_videos: ['BxOBhZBLOio', '9TPXD3-kCfU', 'pFN2n7CRqhw'],
  word_cloud: ["Helpful", "Practical", "Demonstrative", "Detailed", "Instructive", "Visual"],
  description: "Help others to learn the skills you possess in just 5 simple, easy-to-follow steps.",
  sampleimage: 'Steps2.png'
)

puts "#{five_simple_steps.name} blueprint has been created"

comparison = Blueprint.create!(
  name: 'Comparison',
  prompt_template: %{
    "Generate a detailed script comparing the features and specifications of the indicated items,
    highlighting the improvements and differences between them."
    },
  sample_videos: %w[ZOYIJ9LKF0k 8UKikrUZg7Q wmb5AmE4TUs],
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
  sample_videos: ['zIqR43D4CwI', '3s3CmyepjMc', 'uPX1ObBBt_U'],
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
  sample_videos: ['AwPq-7BrzDo', 'QNV4gHWZ9p4', 'y8Y456JmDzw'],
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
  sample_videos: ['h2vAozPxvzU', 'O6UedmnRJc0', 'y8Y456JmDzw'],
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

top_ten = Blueprint.create!(
  name: "The top 10 _____ ",
  prompt_template: "Script a video in which the narrator lists and describes a top ten list for an indicated topic.
  Make sure that the narrator details each item in the list along the way. Please ensure it’s engaging and suitable for a diverse audience.
  The title of the video should be something like 'The top 10 most [topic]', or 'The top 10 [topic]'.",
  sample_videos: ['dj3hWDMqc1c', 'VSiERa2Cp_E', 'V86wOWTUr04'],
  word_cloud: ["Informative", "Compelling", "Unknown", "Curated", "Noteworthy", "Inspiring"],
  description: "Inform your audience of the world they live in with your own top ten list.",
  sampleimage: 'Top2.png'
)

puts "#{top_ten.name} blueprint has been created"

puts 'Finished!'
