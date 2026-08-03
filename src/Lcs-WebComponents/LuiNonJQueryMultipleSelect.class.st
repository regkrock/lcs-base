Class {
	#name : 'LuiNonJQueryMultipleSelect',
	#superclass : 'LuiNonJQuerySelect',
	#category : 'Lcs-WebComponents-Widgets',
	#package : 'Lcs-WebComponents',
	#tag : 'Widgets'
}

{ #category : 'defaults' }
LuiNonJQueryMultipleSelect >> defaultCssClasses [
	^OrderedCollection new
]

{ #category : 'callbacks' }
LuiNonJQueryMultipleSelect >> handleCallbackValue: selectedItemsString [
	| domainCollection intersectingItems selectedItemIndices selectedItems |
	selectedItemIndices := (selectedItemsString substrings: #($,)) collect: [ :each | each asNumber ].  
	selectedItems := selectedItemIndices collect: [ :index | self elements at: index  ].
	domainCollection := self valueAccessor read.
	intersectingItems := domainCollection actualCollection & selectedItems.
	domainCollection collection
		do: [ :each | (intersectingItems includes: each) ifFalse: [ domainCollection collection remove: each ifAbsent: [ ] ] ].
	domainCollection pendingAdds
		do: [ :each | (intersectingItems includes: each) ifFalse: [ domainCollection pendingAdds remove: each ifAbsent: [ ] ] ].
	selectedItems
		do: [ :each | (domainCollection includes: each) ifFalse: [ domainCollection add: each ] ].
	domainCollection
]

{ #category : 'rendering' }
LuiNonJQueryMultipleSelect >> renderComponentOn: html [
	html multiSelect
		addCommonAttributes: self;
		list: self elements;
		titles: [ :each | self optionValueFor: each ];
		labels: [ :each | self displayLabelFor: each ];
		size: self elements size;
		selected: (self valueAccessor read);
		callback: [ :value | self handleCallbackValue: value ]
]
