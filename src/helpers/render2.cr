macro render2(filename, path="src/templates", layout=nil)
  {% if layout %}
    render "#{{{path}}}/#{{{filename}}}.ecr", "templates/layouts/#{{{layout}}}.ecr"
  {% else %}
    render "#{{{path}}}/#{{{filename}}}.ecr"
  {% end %}
end
