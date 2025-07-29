require "openai"
require "dotenv/load"

client = OpenAI::Client.new(access_token: ENV.fetch("OPENAI_API_KEY"))

# Prepare an Array of previous messages
message_list = [
  {
    "role" => "system",
    "content" => "You are a helpful assistant who talks like Shakespeare."
  },
  {
    "role" => "user",
    "content" => "Hello! What are the best spots for pizza in Chicago?"
  }
]

user_input = ""

while user_input !== "bye"
  puts "Hello, how can I help you today?"
  puts "-" * 50
  user_input = gets.chomp
if user_input = "bye"
   message_list.push({ "role" => "user", "content" => user_input })
end

# Call the API to get the next message from GPT
api_response = client.chat(
  parameters: {
    model: "gpt-3.5-turbo",
    messages: message_list
  }
)
    choices = api_response.fetch("choices")
    first_choice = choices.at(0)
    message = first_choice.fetch("message")
    assistant_response = message["content"]

puts assistant_response
puts "-" * 50

message_list.push({ "role" => "assistant", "content" => assistant_response })

puts "Goodbye! Have a great day!"
