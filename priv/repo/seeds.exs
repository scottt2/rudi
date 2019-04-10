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
  },
  %Rudi.Drills.Skill{
    name: "Description of environment",
    description: "Second person voice is when the audience is made a character.
     For this skill, focus your creative efforts on detailing the lay of the
     land as it existed and the appearances of characters rather than dialog.",
    perspective: "second",
    tense: "past",
    weight: 2,
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
  },
  %Rudi.Drills.Skill{
    name: "Description of environment",
    description: "Second person voice is when the audience is made a character.
     For this skill, focus your creative efforts on detailing the lay of the
     land as it exists and the appearances of characters rather than dialog.",
    perspective: "second",
    tense: "present",
    weight: 2,
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
  },
  %Rudi.Drills.Skill{
    name: "Character dialog",
    description: "Second person voice is when the audience is made a character.
     For this skill, focus your creative efforts on detailing the words spoken
     between characters (even if just one to themselves).",
    perspective: "second",
    tense: "past",
    weight: 2,
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
  },
  %Rudi.Drills.Skill{
    name: "Character dialog",
    description: "Second person voice is when the audience is made a character.
     For this skill, focus your creative efforts on detailing the words spoken
     between characters (even if just one to themselves).",
    perspective: "second",
    tense: "present",
    weight: 2,
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
  },
  %Rudi.Drills.Skill{
    name: "Stream of conciousness",
    description: "First person voice is revealed through
     a narrator who is also explicitly a character within their own story.
     For this skill, just let it rip. Try to not stop typing even if what you are
     typing doesn't make sense (yet...).",
    perspective: "first",
    tense: "stream",
    weight: 5,
  },
  %Rudi.Drills.Skill{
    name: "Stream of conciousness",
     description: "Second person voice is when the audience is made a character.
     For this skill, just let it rip. Try to not stop typing even if what you are
     typing doesn't make sense (yet...).",
    perspective: "second",
    tense: "stream",
    weight: 1,
  },
  %Rudi.Drills.Skill{
    name: "Stream of conciousness",
    description: "Third person voice makes it clear that the narrator is an
     unspecified entity or uninvolved person who conveys the story.
     For this skill, just let it rip. Try to not stop typing even if what you are
     typing doesn't make sense (yet...)",
    perspective: "third",
    tense: "stream",
    weight: 5,
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
    nil -> Rudi.Repo.insert!(%Rudi.Accounts.User{ name: "Rudi", username: "rudi" })
    rudi -> rudi
  end

[
  "Artificial Intelligence has determined humanity can no longer exist but the explanation is 'artichoke.'",
  "A faithful spouse of 26 years is informed during routine bloodwork that they are HIV positive.",
  "'My wife's goddamn rollblades'",
  "The sign read 'Please refrain from using the word zza.'",
  "'We seem to be experiencing quantum packet loss. We apologize for any inconvenience.'"
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

