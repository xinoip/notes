# Opencode CLI

`opencode` is a CLI AI coding agent and harness provider.

In these notes, I will explore and learn about the patterns to effectively use
AI models for actual engineering tasks. I will focus on:

- Reducing costs: those tokens are not cheap.
- Faster execution
- Context optimization
- Multi agents
- Custom prompts, skills etc.

These all feel like '_horoscope_ for programmers' for now.

## AGENTS.md File

The main rule file. `/init` creates it using tokens. I think creating it with
LLMs kinda defeats the purpose of it. We should handcraft that file, probably.

I have saved an example `AGENTS.md` file at [[example_agents_md_file]].

Another example showcases giving specific manual instructions is saved at
[[example_agents_md_file_manual_instructions]].

Example `AGENTS.md` files are taken directly from `opencode` docs.

## Model Names

In order to reference models in config files of `opencode`, you need to use the
canonical name of the model. These can be listed with `opencode models` on CLI.

For example, you can't just use `GLM-5.1` as model name. It is canonical name is
`opencode-go/glm-5.1`.
