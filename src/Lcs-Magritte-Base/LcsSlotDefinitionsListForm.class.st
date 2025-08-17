Class {
	#name : #LcsSlotDefinitionsListForm,
	#superclass : #Object,
	#instVars : [
		'targetClass'
	],
	#category : #'Lcs-Magritte-Base-Forms - Models'
}

{ #category : #'as yet unclassified' }
LcsSlotDefinitionsListForm >> classFilterModel [
	<gtExample>
	<return: #GtFilterTextModel>
	^ GtFilterTextModel new
		creator: [ :value | self pattern: value ];
		named: 'Class';
		order: 15;
		completion: [ 
			GtStringsCompletionStrategy new
				completions: [ 
					GtPrefixTree withAll: (LcsDomainObject allSubclasses collect: #name) ]   ] 
]

{ #category : #'as yet unclassified' }
LcsSlotDefinitionsListForm >> filtersModel [
	<gtExample>
	<return: #GtFilterItemsModel>
	| aFiltersModel someAnnouncements |
	someAnnouncements := OrderedCollection new.
	aFiltersModel := GtFilterItemsModel new.
	aFiltersModel weak
		when: GtFiltersModelUpdated
		send: #add:
		to: someAnnouncements.

	aFiltersModel addFilterModel: self slotKindFilterModel.
	aFiltersModel addFilterModel: self slotClassFilterModel.
	aFiltersModel addFilterModel: self superclassesFilter.
	^ aFiltersModel
]

{ #category : #'as yet unclassified' }
LcsSlotDefinitionsListForm >> pattern: aString [
	^ GtSearchMethodsWithClassPatternFilter new
		pattern: aString;
		yourself
]

{ #category : #'as yet unclassified' }
LcsSlotDefinitionsListForm >> slotClassFilterModel [
	<gtExample>
	<return: #GtFilterTextModel>
	^ GtFilterTextModel new
		creator: [ :value | self pattern: value ];
		named: 'Slot Class';
		order: 15;
		completion: [ 
			GtStringsCompletionStrategy new
				completions: [ 
					GtPrefixTree withAll: (LcsBaseSlot allSubclasses collect: #name) ]   ] 
]

{ #category : #'as yet unclassified' }
LcsSlotDefinitionsListForm >> slotKindFilterModel [
	<gtExample>
	<return: #GtFilterShortListModel>
	| aModel |
	aModel := GtFilterShortListModel new.
	aModel
		items: {'all'.
				'accessor'.
				'virtual'.
				'facade'}.
	aModel selectedItem: 'all'.
	aModel name: 'Kind'.
	^ aModel
]

{ #category : #'as yet unclassified' }
LcsSlotDefinitionsListForm >> superclassesFilter [
	<gtExample>
	<return: #GtFilterShortListModel>
	| aCurrentClass |
	aCurrentClass := LxxPerson.
	^ GtFilterShortListModel new
		creator: [ :anItem | 
			anItem
				ifSome: [ :anUpToClass | (self forClass: aCurrentClass) withSuperclassesUpTo: anUpToClass ]
				ifNone: [ (self forClass: aCurrentClass) withSuperclassesUpTo: aCurrentClass ] ];
		items: [ ((ReadStream on: aCurrentClass withAllSuperclasses) upTo: LcsObject)  ];
		selectedItem: aCurrentClass;
		displayAllItems;
		name: 'Slots up to';
		order: 16
]

{ #category : #accessing }
LcsSlotDefinitionsListForm >> targetClass [
	^ targetClass
]

{ #category : #accessing }
LcsSlotDefinitionsListForm >> targetClass: anObject [
	targetClass := anObject
]
