defmodule Rudi.DrillsTest do
  use Rudi.DataCase

  alias Rudi.Drills

  describe "seeds" do
    alias Rudi.Drills.Seed

    @valid_attrs %{body: "some body", public: true}
    @update_attrs %{body: "some updated body", public: false}
    @invalid_attrs %{body: nil, public: nil}

    def seed_fixture(attrs \\ %{}) do
      {:ok, seed} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Drills.create_seed()

      seed
    end

    test "list_seeds/0 returns all seeds" do
      seed = seed_fixture()
      assert Drills.list_seeds() == [seed]
    end

    test "get_seed!/1 returns the seed with given id" do
      seed = seed_fixture()
      assert Drills.get_seed!(seed.id) == seed
    end

    test "create_seed/1 with valid data creates a seed" do
      assert {:ok, %Seed{} = seed} = Drills.create_seed(@valid_attrs)
      assert seed.body == "some body"
      assert seed.public == true
    end

    test "create_seed/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Drills.create_seed(@invalid_attrs)
    end

    test "update_seed/2 with valid data updates the seed" do
      seed = seed_fixture()
      assert {:ok, %Seed{} = seed} = Drills.update_seed(seed, @update_attrs)
      assert seed.body == "some updated body"
      assert seed.public == false
    end

    test "update_seed/2 with invalid data returns error changeset" do
      seed = seed_fixture()
      assert {:error, %Ecto.Changeset{}} = Drills.update_seed(seed, @invalid_attrs)
      assert seed == Drills.get_seed!(seed.id)
    end

    test "delete_seed/1 deletes the seed" do
      seed = seed_fixture()
      assert {:ok, %Seed{}} = Drills.delete_seed(seed)
      assert_raise Ecto.NoResultsError, fn -> Drills.get_seed!(seed.id) end
    end

    test "change_seed/1 returns a seed changeset" do
      seed = seed_fixture()
      assert %Ecto.Changeset{} = Drills.change_seed(seed)
    end
  end

  describe "skills" do
    alias Rudi.Drills.Skill

    @valid_attrs %{description: "some description", name: "some name"}
    @update_attrs %{description: "some updated description", name: "some updated name"}
    @invalid_attrs %{description: nil, name: nil}

    def skill_fixture(attrs \\ %{}) do
      {:ok, skill} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Drills.create_skill()

      skill
    end

    test "list_skills/0 returns all skills" do
      skill = skill_fixture()
      assert Drills.list_skills() == [skill]
    end

    test "get_skill!/1 returns the skill with given id" do
      skill = skill_fixture()
      assert Drills.get_skill!(skill.id) == skill
    end

    test "create_skill/1 with valid data creates a skill" do
      assert {:ok, %Skill{} = skill} = Drills.create_skill(@valid_attrs)
      assert skill.description == "some description"
      assert skill.name == "some name"
    end

    test "create_skill/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Drills.create_skill(@invalid_attrs)
    end

    test "update_skill/2 with valid data updates the skill" do
      skill = skill_fixture()
      assert {:ok, %Skill{} = skill} = Drills.update_skill(skill, @update_attrs)
      assert skill.description == "some updated description"
      assert skill.name == "some updated name"
    end

    test "update_skill/2 with invalid data returns error changeset" do
      skill = skill_fixture()
      assert {:error, %Ecto.Changeset{}} = Drills.update_skill(skill, @invalid_attrs)
      assert skill == Drills.get_skill!(skill.id)
    end

    test "delete_skill/1 deletes the skill" do
      skill = skill_fixture()
      assert {:ok, %Skill{}} = Drills.delete_skill(skill)
      assert_raise Ecto.NoResultsError, fn -> Drills.get_skill!(skill.id) end
    end

    test "change_skill/1 returns a skill changeset" do
      skill = skill_fixture()
      assert %Ecto.Changeset{} = Drills.change_skill(skill)
    end
  end

  describe "prompts" do
    alias Rudi.Drills.Prompt

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def prompt_fixture(attrs \\ %{}) do
      {:ok, prompt} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Drills.create_prompt()

      prompt
    end

    test "list_prompts/0 returns all prompts" do
      prompt = prompt_fixture()
      assert Drills.list_prompts() == [prompt]
    end

    test "get_prompt!/1 returns the prompt with given id" do
      prompt = prompt_fixture()
      assert Drills.get_prompt!(prompt.id) == prompt
    end

    test "create_prompt/1 with valid data creates a prompt" do
      assert {:ok, %Prompt{} = prompt} = Drills.create_prompt(@valid_attrs)
    end

    test "create_prompt/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Drills.create_prompt(@invalid_attrs)
    end

    test "update_prompt/2 with valid data updates the prompt" do
      prompt = prompt_fixture()
      assert {:ok, %Prompt{} = prompt} = Drills.update_prompt(prompt, @update_attrs)
    end

    test "update_prompt/2 with invalid data returns error changeset" do
      prompt = prompt_fixture()
      assert {:error, %Ecto.Changeset{}} = Drills.update_prompt(prompt, @invalid_attrs)
      assert prompt == Drills.get_prompt!(prompt.id)
    end

    test "delete_prompt/1 deletes the prompt" do
      prompt = prompt_fixture()
      assert {:ok, %Prompt{}} = Drills.delete_prompt(prompt)
      assert_raise Ecto.NoResultsError, fn -> Drills.get_prompt!(prompt.id) end
    end

    test "change_prompt/1 returns a prompt changeset" do
      prompt = prompt_fixture()
      assert %Ecto.Changeset{} = Drills.change_prompt(prompt)
    end
  end
end
