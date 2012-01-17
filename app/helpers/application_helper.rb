module ApplicationHelper
  def show_error_messages_for(model)
    render 'shared/error_messages', model: model unless model.errors.empty?
  end
  
  def pagination_links(objects, params = nil)
    result = will_paginate objects, inner_window: 1, outer_window: 1,
      params: params, renderer: BootstrapPaginationHelper::LinkRenderer
    
    unless result
      previous_tag = content_tag(
        :li,
        content_tag(:a, t('will_paginate.previous_label').html_safe),
        class: 'prev disabled'
      )
      next_tag = content_tag(
        :li,
        content_tag(:a, t('will_paginate.next_label').html_safe),
        class: 'next disabled'
      )
      current_tag = content_tag(:li, content_tag(:a, '1'), class: 'active')
      
      result = content_tag(
        :div,
        content_tag(:ul, previous_tag + current_tag + next_tag),
        class: 'pagination'
      )
    end

    result
  end
  
  def link_to_edit(*args)
    options = {
      'class' => 'iconic',
      'title' => t('label.edit'),
      'data-twipsy' => true
    }.merge(args.extract_options!)
    
    link_to '&#x270e;'.html_safe, *args, options
  end
  
  def link_to_delete(*args)
    options = {
      'class' => 'iconic',
      'confirm' => t('messages.confirmation'),
      'title' => t('label.delete'),
      'method' => :delete,
      'data-twipsy' => true
    }.merge(args.extract_options!)
    
    link_to '&#x2714;'.html_safe, *args, options
  end
end
