Class {
	#name : 'LuiMultiselect',
	#superclass : 'LuiSelect',
	#category : 'Lcs-WebComponents-Widgets',
	#package : 'Lcs-WebComponents',
	#tag : 'Widgets'
}

{ #category : 'defaults' }
LuiMultiselect >> defaultCssClasses [
	^OrderedCollection new
]

{ #category : 'callbacks' }
LuiMultiselect >> handleCallbackValue: selectedItemsString [
	| domainCollection intersectingItems selectedTagValues selectedItems |
	selectedTagValues := (selectedItemsString substrings: #($,)).
	selectedItems := selectedTagValues collect: [ :eachTagValue | (self orderedComponents detect: [ :each | each  htmlTagValue = eachTagValue ]) model ].
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
LuiMultiselect >> renderComponentOn: html [
	html multiSelect
		addCommonAttributes: self;
		"list: self elements;
		titles: [ :each | self optionValueFor: each ];
		labels: [ :each | self displayLabelFor: each ];
		size: self elements size;
		selected: (self valueAccessor read);"
		onBlur: (self handleCallbackAndRenderDependents: html);
		with: [ self renderDetailsOn: html ]
]
