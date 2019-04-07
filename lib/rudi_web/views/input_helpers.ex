defmodule RudiWeb.InputHelpers do
  use Phoenix.HTML

  def input(form, field, opts \\ []) do
    type = opts[:using] || Phoenix.HTML.Form.input_type(form, field)

    wrapper_opts = [class: "w-full max-w-xs #{state_class(form, field)}"]
    label_opts = [class: "block text-grey-darker text-sm font-bold mb-1 mt-4"]
    input_opts = [class: "#{input_state_class(form, field)} shadow appearance-none border rounded w-full py-2 px-3 text-grey-darker leading-tight focus:outline-none focus:shadow-outline"]

    content_tag :div, wrapper_opts do
      label = label(form, field, humanize(field), label_opts)
      input = input(type, form, field, input_opts)
      error = RudiWeb.ErrorHelpers.error_tag(form, field)
      [label, input, error || ""]
    end
  end

  defp input_state_class(form, field) do
    cond do
      !form.action -> ""
      !form.source.action -> ""
      form.errors[field] -> "border-red"
      true -> "has-success"
    end
  end

  defp state_class(form, field) do
    cond do
      !form.action -> ""
      !form.source.action -> ""
      form.errors[field] -> "has-error"
      true -> "has-success"
    end
  end

  # TODO: Complete this and use for assignments
  defp input(:kvp, form, field, input_opts) do
    l_input_opts =
      [
        class: "w-full md:w-1/3 mr-1 #{input_state_class(form, field)} shadow appearance-none border rounded w-full py-2 px-3 text-grey-darker leading-tight focus:outline-none focus:shadow-outline",
        placeholder: "Key"
      ]
    r_input_opts =
      [
        class: "w-full md:w-1/2 #{input_state_class(form, field)} shadow appearance-none border rounded w-full py-2 px-3 text-grey-darker leading-tight focus:outline-none focus:shadow-outline",
        placeholder: "Value"
      ]
    button_opts =
      [
        class: "kvp-add py-2 px-4 rounded-full"
      ]

    content_tag :div, [] do
      l_input = input(:text_input, form, field, l_input_opts)
      r_input = input(:text_input, form, field, r_input_opts)
      button  = content_tag(:button, "+", button_opts)
      [l_input, r_input, button]
    end
  end

  defp input(type, form, field, input_opts) do
    apply(Phoenix.HTML.Form, type, [form, field, input_opts])
  end
end