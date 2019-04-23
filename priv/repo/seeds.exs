# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Rudi.Repo.insert!(%Rudi.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

[
  %Rudi.Drills.Skill{
    name: "Description of environment",
    description: "First person voice is revealed through
     a narrator who is also explicitly a character within their own story.
     For this skill, focus your creative efforts on detailing the lay of the
     land as it existed and the appearances of characters rather than dialog.",
    perspective: "first",
    tense: "past",
    weight: 5,
    type: "prompt"
  },
  %Rudi.Drills.Skill{
    name: "Description of environment",
    description: "Third person voice makes it clear that the narrator is an
     unspecified entity or uninvolved person who conveys the story.
     For this skill, focus your creative efforts on detailing the lay of the
     land as it existed and the appearances of characters rather than dialog.",
    perspective: "third",
    tense: "past",
    weight: 7,
    type: "prompt"
  },
  %Rudi.Drills.Skill{
    name: "Description of environment",
    description: "First person voice is revealed through
     a narrator who is also explicitly a character within their own story.
     For this skill, focus your creative efforts on detailing the lay of the
     land as it exists and the appearances of characters rather than dialog.",
    perspective: "first",
    tense: "present",
    weight: 5,
    type: "prompt"
  },
  %Rudi.Drills.Skill{
    name: "Description of environment",
    description: "Third person voice makes it clear that the narrator is an
     unspecified entity or uninvolved person who conveys the story.
     For this skill, focus your creative efforts on detailing the lay of the
     land as it exists and the appearances of characters rather than dialog.",
    perspective: "third",
    tense: "present",
    weight: 7,
    type: "prompt"
  },
  %Rudi.Drills.Skill{
    name: "Character dialog",
    description: "First person voice is revealed through
     a narrator who is also explicitly a character within their own story.
     For this skill, focus your creative efforts on detailing the words spoken
     between characters (even if just one to themselves).",
    perspective: "first",
    tense: "past",
    weight: 5,
    type: "prompt"
  },
  %Rudi.Drills.Skill{
    name: "Character dialog",
    description: "Third person voice makes it clear that the narrator is an
     unspecified entity or uninvolved person who conveys the story.
     For this skill, focus your creative efforts on detailing the words spoken
     between characters (even if just one to themselves).",
    perspective: "third",
    tense: "past",
    weight: 7,
    type: "prompt"
  },
  %Rudi.Drills.Skill{
    name: "Character dialog",
    description: "First person voice is revealed through
     a narrator who is also explicitly a character within their own story.
     For this skill, focus your creative efforts on detailing the words spoken
     between characters (even if just one to themselves).",
    perspective: "first",
    tense: "present",
    weight: 5,
    type: "prompt"
  },
  %Rudi.Drills.Skill{
    name: "Character dialog",
    description: "Third person voice makes it clear that the narrator is an
     unspecified entity or uninvolved person who conveys the story.
     For this skill, focus your creative efforts on detailing the words spoken
     between characters (even if just one to themselves).",
    perspective: "third",
    tense: "present",
    weight: 7,
    type: "prompt"
  },
  %Rudi.Drills.Skill{
    name: "Free Write",
    description: "Free writing is a great tool for overcoming inhibitions. For
    this skill, try to continuously type without regard to spelling or grammar.
    The goal is to let your ideas bypass your ego. Let your thoughts flow!",
    perspective: "free",
    tense: "free",
    weight: 7,
    type: "prompt"
  },
  %Rudi.Drills.Skill{
    name: "Target Acquistion",
    description: "Simply put, this skills is how fast you can hunt and peck
     a given key. Mastery of this skill should have consistent seek times regardless
     of key, enabling faster composition.",
    perspective: "none",
    tense: "none",
    weight: 7,
    type: "typing"
  },
  %Rudi.Drills.Skill{
    name: "Word Composition",
    description: "The abililty to type words is the gateway to crafting written
     expression. This skill has two components: one is how fast can you type a given
     word; the other, how accurately can you type that word.",
    perspective: "none",
    tense: "none",
    weight: 7,
    type: "typing"
  },
]
|> Enum.each fn skill ->
  case Rudi.Repo.get_by(Rudi.Drills.Skill, name: skill.name, perspective: skill.perspective, tense: skill.tense) do
    nil -> Rudi.Repo.insert!(skill)
    _ -> IO.puts ("#{skill.name} with #{skill.perspective} POV in #{skill.tense} tense exists.")
  end
end

rudi =
  case Rudi.Repo.get_by(Rudi.Accounts.User, username: "rudi") do
    nil -> Rudi.Repo.insert!(%Rudi.Accounts.User{name: "Rudi", username: "rudi"})
    rudi -> rudi
  end

[
  "Artificial Intelligence has determined humanity can no longer exist but the explanation is \"artichoke.\"",
  "A faithful spouse of 26 years is informed during routine bloodwork that they are HIV positive.",
  "\"My wife's goddamn rollblades\"",
  "The sign read \"Please refrain from using the word zza.\"",
  "\"We seem to be experiencing quantum packet loss. We apologize for any inconvenience.\"",
  "\"Sour grapes\"",

]
|> Enum.each fn body ->
  case Rudi.Repo.get_by(Rudi.Drills.Seed, body: body) do
    nil ->
      Rudi.Repo.insert!(%Rudi.Drills.Seed{
        author_id: rudi.id,
        body: body,
        promptable: true,
        public: true
      })
    _ -> IO.puts ("#{body} exists.")
  end
end

Rudi.Repo.insert!(%Rudi.Drills.Prompt{
  seed_id: 1,
  skill_id: 1
})

file_tuples = [
  {1, "character", "data/freq_en_characters.json"},
  {2, "character", "data/freq_en_bigram_characters.json"},
  {3, "character", "data/freq_en_trigram_characters.json"},
  {4, "character", "data/freq_en_quadrigrams_characters.json"},
]

file_tuples |> Enum.each fn {n, gram_type, file} ->
  {:ok, body} = File.read(Path.relative_to_cwd(file))
  body
  |> Jason.decode!
  |> Enum.each fn [char, freq] ->
    case Rudi.Repo.get_by(Rudi.Drills.Ngram, body: char) do
      nil ->
        Rudi.Repo.insert!(%Rudi.Drills.Ngram{
          body: char,
          frequency: Integer.floor_div(freq, 1000),
          gram_type: gram_type, 
          n: n,
        })
      _ -> IO.puts("#{char} exists.")
    end
  end
end

File.stream!(Path.relative_to_cwd("data/en_phrases.txt"))
|> Enum.take(20)
|> Enum.each fn line -> 
  [_ | words] = String.split(line, ~r{\s}, trim: true)
  start_chars =
    words
    |> Enum.map(fn w -> String.first(w) end)
    |> Enum.join("")
  # TODO: Create phrase schema. Store phrase and start chars. Uniq start chars.
end
