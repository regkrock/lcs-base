Class {
	#name : 'LuiMultipleSelect',
	#superclass : 'LuiSelect',
	#category : 'Lcs-WebComponents-Widgets',
	#package : 'Lcs-WebComponents',
	#tag : 'Widgets'
}

{ #category : 'callbacks' }
LuiMultipleSelect >> handleCallbackValue: selectedItemsString [
	| domainCollection intersectingItems selectedItemIndices selectedItems |
	selectedItemIndices := (selectedItemsString substrings: #($,)) collect: [ :each | each asNumber ].  
	selectedItems := selectedItemIndices collect: [ :index | self elements at: index  ].
	domainCollection := self valueAccessor read.
	intersectingItems := domainCollection collection & selectedItems.
	domainCollection
		do: [ :each | (intersectingItems includes: each) ifFalse: [ domainCollection remove: each ] ].
	selectedItems
		do: [ :each | (domainCollection includes: each) ifFalse: [ domainCollection add: each ] ]
]

{ #category : 'rendering' }
LuiMultipleSelect >> renderComponentOn: html [
	html multiSelect
		addCommonAttributes: self;
		list: self elements;
		titles: [ :each | self optionValueFor: each ];
		labels: [ :each | self displayLabelFor: each ];
		size: self elements size;
		selected: (self valueAccessor read);
		onBlur: (self handleCallbackAndRenderDependents: html)";
		callback: [ :value | self handleCallbackValue: value ]"
]
