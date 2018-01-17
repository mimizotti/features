$ ->
  $("input:radio").change(->
    if $(this).prop("checked", true)
      price = "<b>#{$(this).data('price')}</b>"
      dimensions = "<b>#{$(this).data('dimensions')}</b>"
      $("#product_details").html("#{price}#{dimensions}")
  )

  $("#add_to_cart").click((e)->
    e.preventDefault()

    $input = $("input:radio:checked")
    $label = $("label[for='#{$input.attr("id")}']")
    $form = $('#new_order')
    product_id = $input.val()
    $hidden_input = "<input type='hidden' name='#{$input.attr('name')}' value='#{product_id}' />"

    $form.prepend($hidden_input)
    product = $label[0].innerText.split('$')

    render_cart(product)

    $.each($form.find("input:hidden"), (index, value) ->
      $(this).attr('name', $(this).attr('name').replace(/\d+/g, index))
    )
  )

  render_cart = (product) ->
    parameterize_name = product[0].replace(/ /g, '-')
    product_name = product[0]
    product_price = product[1]

    if $('#' + parameterize_name).length
      update_cart(parameterize_name, product_name, product_price)
    else
      $("#cart").append(
        "<span id='#{parameterize_name}' quantity='1'>#{product_name}</span>
        $<span id='#{parameterize_name}price'>#{product_price}</span></br>"
      )

  update_cart = (parameterize_name, product_name, product_price) ->
      quantity = parseInt($('#' + parameterize_name).attr("quantity")) + 1
      updated_product_price = parseInt($('#' + parameterize_name + 'price').text()) + parseInt(product_price)

      $('#' + parameterize_name).replaceWith(
        "<span id='#{parameterize_name}' quantity='#{quantity}'>(#{quantity}) #{product_name}</span>"
      )

      $('#' + parameterize_name + 'price').replaceWith(
        "<span id='#{parameterize_name}price'>#{updated_product_price.toFixed(2)}</span>"
      )


