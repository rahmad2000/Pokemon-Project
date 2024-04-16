module ApplicationHelper
  def tailwind_paginate(objects)
    paginate objects, theme: 'tailwind'
  end
end
