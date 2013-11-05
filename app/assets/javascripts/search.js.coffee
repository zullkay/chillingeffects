$rows = new AdvancedSearchRows()

$('form[action="/notices/search"]:not("#facets-form")').on 'submit', ->
  $(this)
    .find('[name="search-field"],[name="search-term"]')
    .attr('disabled','disabled')

$('#duplicate-field').on 'click', ->
  $rows.addField()

$('.advanced-search').on 'change', '.field-group select', (event) ->
  fieldGroup = $(this).closest('.field-group')
  $rows.fieldChanged(fieldGroup)
  $rows.syncDataFields()
  # So when a field changes, we need to
  # 1) Update its state in the UI,
  # 2) Iterate over fields and ensure they don't have broken select choices,
  # 3) Update the stored DOM elements that keep search terms
  # 4) Ensure we insert a template row that doesn't contain stuck search terms.

$('.advanced-search').on 'click', '.remove-group', (event) ->
  fieldGroup = $(this).closest('.field-group')
  $rows.removeField(fieldGroup)

$('.results-context-toggle').click ->
  $('.results-context').slideToggle
    duration: 'fast'
    easing: 'easeOutCirc'

$ ->
  $rows.displayActiveFields()
