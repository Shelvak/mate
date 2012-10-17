module FlowsHelper
  def in_or_out_select_for_flow(form)
    in_or_out_collection = [
      [t('view.flows.in'), true], [t('view.flows.out'), false]
    ]

    form.input :in, collection: in_or_out_collection,
      selected: form.object.in, prompt: false,
      input_html: { class: 'span6' }
  end
end
