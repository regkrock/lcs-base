Class {
	#name : 'LcsGtPhlowColumnedListViewExamples',
	#superclass : 'LcsObjectExamples',
	#category : 'Lcs-PrototypeSystemTests-Examples',
	#package : 'Lcs-PrototypeSystemTests',
	#tag : 'Examples'
}

{ #category : 'examples' }
LcsGtPhlowColumnedListViewExamples >> _slotsUpToFilter [
	<gtExample>
	| filter |
	self ensureCurrentSystemIsPrototypeSystem.
	filter := LcsGtPhlowColumnedListView new _superclassesFilter: LxxPerson.
	self assert: filter selectedItem class equals: GtFilterModelNoItem.
	^ filter
]

{ #category : 'examples' }
LcsGtPhlowColumnedListViewExamples >> _slotsUpToLastItemFilter [
	<gtExample>
	| filter |
	self ensureCurrentSystemIsPrototypeSystem.
	filter := LcsGtPhlowColumnedListView new _superclassesFilter: LxxPerson.
	self assert: filter selectedItem class equals: GtFilterModelNoItem.
	filter selectLastItem.
	self assert: filter selectedItem itemValue equals: LcsBaseDomainObject.
	self assert: (filter creator value: filter selectedItem) equals: self allClassInDomainObjectHeirarchy.
	^ filter
]

{ #category : 'examples' }
LcsGtPhlowColumnedListViewExamples >> allClassInDomainObjectHeirarchy [
	^ {LxxPerson.
		LxxBasePerson.
		LcsDomainObject.
		LcsBaseDomainObject} asOrderedCollection
]

{ #category : 'examples' }
LcsGtPhlowColumnedListViewExamples >> domainClassFilter [
	<gtExample>
	| filter result |
	self ensureCurrentSystemIsPrototypeSystem.
	filter := LcsGtPhlowColumnedListView new newDomainClassFilter.
	self assert: filter selectedValue equals: ''.
	filter text: 'LxxPerson'.
	self assert: filter selectedValue equals: 'LxxPerson'.
	result := filter creator value: filter selectedValue.
	^ filter
]

{ #category : 'examples' }
LcsGtPhlowColumnedListViewExamples >> filterItemsUsingDefaultFilters [
	<gtExample>
	^ self slotModelView filteredItems
]

{ #category : 'examples' }
LcsGtPhlowColumnedListViewExamples >> sloKindFilterWithLastItemSelected [
	<gtExample>
	| filter |
	self ensureCurrentSystemIsPrototypeSystem.
	filter := LcsGtPhlowColumnedListView new newSlotKindFilter.
	self assert: filter notNil.
	self assert: filter selectedItem itemValue equals: 'all'.
	filter selectLastItem.
	self assert: filter selectedItem itemValue equals: 'virtual'.
	^ filter
]

{ #category : 'examples' }
LcsGtPhlowColumnedListViewExamples >> slotClassFilter [
	<gtExample>
	| filter result |
	self ensureCurrentSystemIsPrototypeSystem.
	filter := LcsGtPhlowColumnedListView new newSlotClassFilter.
	self assert: filter selectedValue equals: ''.
	filter text: 'LxxPerson'.
	self assert: filter selectedValue equals: 'LxxPerson'.
	result := filter creator value: filter selectedValue.
	^ filter
]

{ #category : 'examples' }
LcsGtPhlowColumnedListViewExamples >> slotDefinitionItemsFilteredByAccessorSlotKind [
	<gtExample>
	| view  filteredItems |
	view := self viewWithSlotDefinitionItemsFilteredByAccessorSlotKind.
	filteredItems := view filteredItems.
	self assert: filteredItems size equals: 3.
	^ filteredItems
]

{ #category : 'examples' }
LcsGtPhlowColumnedListViewExamples >> slotKindFilter [
	<gtExample>
	| filter |
	self ensureCurrentSystemIsPrototypeSystem.
	filter := LcsGtPhlowColumnedListView new newSlotKindFilter.
	self assert: filter notNil.
	self assert: filter selectedItem itemValue equals: 'all'.
	^ filter
]

{ #category : 'examples' }
LcsGtPhlowColumnedListViewExamples >> slotModelView [
	<gtExample>
	| view element forwardView|
	self ensureCurrentSystemIsPrototypeSystem.
	forwardView := GtPhlowView empty on: LxxPerson perform: #gtViewSlotModelFor:.
	view := forwardView phlowView wait.
	BlUseAsyncFeatures disableDuring: [ 
		element := view asElementDo: [ :anElement | anElement ] ].
	self assert: element phlow entity equals: view.
	self assert: view filterItemsModel items size equals: 4.
	self assert: view itemsProviderComputation printString equals: '[ self allSlotDefinitions ]'.
	self assert: view slotKindFilterItemLabel equals: 'all'.
	self assert: view superclassesFilterItemLabel equals: LxxPerson.
	self assert: view slotClassFilterItemLabel equals: ''.
	self assert: view domainClassFilterItemLabel equals: ''.
	self assert: view slotKindFilterValue equals: nil.
	self assert: view slotClassFilterValue equals: ''.
	self assert: view domainClassFilterValue equals: ''.
	self assert: view superclassesFilterValue equals: (OrderedCollection with: LxxPerson).
	^ view
]

{ #category : 'examples' }
LcsGtPhlowColumnedListViewExamples >> slotsUpToFilter [
	<gtExample>
	| view filter |
	view := self slotModelView.
	filter := view filterItemLabelled: 'Slots up to'.
	self assert: filter notNil.
	self
		assert: filter itemsBuilder valuable value
		equals: self allClassInDomainObjectHeirarchy.
	self assert: filter selectedItem itemValue equals: LxxPerson.
	self assert: filter selectedValue itemValue equals: LxxPerson.
	self
		assert: (filter creator value: filter selectedItem)
		equals: (OrderedCollection with: LxxPerson).
	^ filter
]

{ #category : 'examples' }
LcsGtPhlowColumnedListViewExamples >> slotsUpToFilterWithLastItemSelected [
	<gtExample>
	| filter |
	filter := self slotsUpToFilter.
	self assert: filter notNil.
	filter selectLastItem.
	self assert: (filter creator value: filter selectedItem) equals: self allClassInDomainObjectHeirarchy.
	^ filter
]

{ #category : 'examples' }
LcsGtPhlowColumnedListViewExamples >> unfilteredItems [
	<gtExample>
	| view unfilteredItems |
	view := self slotModelView.
	unfilteredItems := view unfilteredItems.
	self assert: unfilteredItems size > 0.
	^ unfilteredItems
]

{ #category : 'examples' }
LcsGtPhlowColumnedListViewExamples >> viewWithDefaultFiltersSelectedItems [
	<gtExample>
	| view |
	view :=  self slotModelView.
	view filteredItems.
	self assert: view filteredItems size equals: 4.
	^ view
]

{ #category : 'examples' }
LcsGtPhlowColumnedListViewExamples >> viewWithSlotDefinitionItemsFilteredByAccessorSlotKind [
	<gtExample>
	| view accessorItem filter filteredItems |
	view := self viewWithDefaultFiltersSelectedItems.
	filter := view slotKindFilter.
	filter itemsFuture wait.

	accessorItem := filter itemsBuilder items
			detect: [ :each | each itemValue = 'accessor' ]
			ifNone: [ nil ].
	self assert: accessorItem itemValue equals: 'accessor'.
	view slotKindFilter selectedItem: accessorItem.

	filteredItems := view filteredItems.
	self assert: filteredItems size equals: 3.
	^ view
]
