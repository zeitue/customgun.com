module ActionView
  module Helpers
    class FormBuilder
      def date_select(method, options = {}, html_options = {})
        locale = options[:locale] ? options[:locale] : 'en'
        if locale == 'tl'
          locale = 'tl-ph'
        end
        existing_date = @object.send(method)
        formatted_date = existing_date.to_date.strftime("%F") if existing_date.present?
        @template.content_tag(:div, :class => "input-group", :id => "#{method}") do
          @template.content_tag(:span, @template.content_tag(:span, "", :class => "glyphicon glyphicon-calendar") ,:class => "input-group-addon") +
          text_field(method, :value => formatted_date, :class => "form-control datepicker", :"data-date-format" => "YYYY-MM-DD") +
            @template.javascript_tag("  $(function () {$('##{method}').datetimepicker({locale: '#{locale}'});});")
        end
      end

      def datetime_select(method, options = {}, html_options = {})
        locale = options[:locale] ? options[:locale] : 'en'
        if locale == 'tl'
          locale = 'tl-ph'
        end
        existing_time = @object.send(method)
        formatted_time = existing_time.to_time.strftime("%F %I:%M %p") if existing_time.present?
        @template.content_tag(:div, :class => "input-group", :id => "#{method}") do
          @template.content_tag(:span, @template.content_tag(:span, "", :class => "glyphicon glyphicon-calendar") ,:class => "input-group-addon") +
          text_field(method, :value => formatted_time, :class => "form-control datetimepicker", :"data-date-format" => "YYYY-MM-DD hh:mm A") +
          @template.javascript_tag("  $(function () {$('##{method}').datetimepicker({locale: '#{locale}'});});")
        end
      end
    end
  end
end
