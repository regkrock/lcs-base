Class {
	#name : #LcsGtPhlowColumnedListViewExamples,
	#superclass : #LcsObjectExamples,
	#category : #'Lcs-PrototypeSystemTests-Examples'
}

{ #category : #examples }
LcsGtPhlowColumnedListViewExamples >> _slotsUpToFilter [
	<gtExample>
	| filter |
	self ensureCurrentsystemIsPrototypeSystem.
	filter := LcsGtPhlowColumnedListView new _superclassesFilter: LxxPerson.
	self assert: filter selectedItem class equals: GtFilterModelNoItem.
	^ filter
]

{ #category : #examples }
LcsGtPhlowColumnedListViewExamples >> _slotsUpToLastItemFilter [
	<gtExample>
	| filter |
	self ensureCurrentsystemIsPrototypeSystem.
	filter := LcsGtPhlowColumnedListView new _superclassesFilter: LxxPerson.
	self assert: filter selectedItem class equals: GtFilterModelNoItem.
	filter selectLastItem.
	self assert: filter selectedItem itemValue equals: LcsBaseDomainObject.
	self assert: (filter creator value: filter selectedItem) equals: self allClassInDomainObjectHeirarchy.
	^ filter
]

{ #category : #examples }
LcsGtPhlowColumnedListViewExamples >> allClassInDomainObjectHeirarchy [
	^ {LxxPerson.
		LxxBasePerson.
		LcsDomainObject.
		LcsBaseDomainObject} asOrderedCollection
]

{ #category : #examples }
LcsGtPhlowColumnedListViewExamples >> domainClassFilter [
	<gtExample>
	| filter result |
	self ensureCurrentsystemIsPrototypeSystem.
	filter := LcsGtPhlowColumnedListView new domainClassFilter.
	self assert: filter selectedValue equals: ''.
	filter text: 'LxxPerson'.
	self assert: filter selectedValue equals: 'LxxPerson'.
	result := filter creator value: filter selectedValue.
	^ filter
]

{ #category : #examples }
LcsGtPhlowColumnedListViewExamples >> sloKindFilterWithLastItemSelected [
	<gtExample>
	| filter |
	self ensureCurrentsystemIsPrototypeSystem.
	filter := LcsGtPhlowColumnedListView new slotKindFilter.
	self assert: filter notNil.
	self assert: filter selectedItem itemValue equals: 'all'.
	filter selectLastItem.
	self assert: filter selectedItem itemValue equals: 'facade'.
	^ filter
]

{ #category : #examples }
LcsGtPhlowColumnedListViewExamples >> slotClassFilter [
	<gtExample>
	| filter result |
	self ensureCurrentsystemIsPrototypeSystem.
	filter := LcsGtPhlowColumnedListView new slotClassFilter.
	self assert: filter selectedValue equals: ''.
	filter text: 'LxxPerson'.
	self assert: filter selectedValue equals: 'LxxPerson'.
	result := filter creator value: filter selectedValue.
	^ filter
]

{ #category : #examples }
LcsGtPhlowColumnedListViewExamples >> slotKindFilter [
	<gtExample>
	| filter |
	self ensureCurrentsystemIsPrototypeSystem.
	filter := LcsGtPhlowColumnedListView new slotKindFilter.
	self assert: filter notNil.
	self assert: filter selectedItem itemValue equals: 'all'.
	^ filter
]

{ #category : #examples }
LcsGtPhlowColumnedListViewExamples >> slotModelView [
	<gtExample>
	| view element forwardView|
	self ensureCurrentsystemIsPrototypeSystem.
	forwardView := GtPhlowView empty on: LxxPerson perform: #gtViewSlotModelFor:.
	view := forwardView phlowView wait.
	BlUseAsyncFeatures disableDuring: [ 
		element := view asElementDo: [ :anElement | anElement ] ].
	self assert: element phlow entity equals: view.
	self assert: view filterItemsModel items size equals: 4.
	self assert: view itemsProviderComputation printString equals: '[ self allSlotDefinitions ]'.
	^ view
]

{ #category : #examples }
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

{ #category : #examples }
LcsGtPhlowColumnedListViewExamples >> slotsUpToFilterWithLastItemSelected [
	<gtExample>
	| filter |
	filter := self slotsUpToFilter.
	self assert: filter notNil.
	filter selectLastItem.
	self assert: (filter creator value: filter selectedItem) equals: self allClassInDomainObjectHeirarchy.
	^ filter
]
