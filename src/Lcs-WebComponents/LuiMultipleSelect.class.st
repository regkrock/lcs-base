Class {
	#name : 'LuiMultipleSelect',
	#superclass : 'LuiSelect',
	#category : 'Lcs-WebComponents-Widgets',
	#package : 'Lcs-WebComponents',
	#tag : 'Widgets'
}

{ #category : 'callbacks' }
LuiMultipleSelect >> handleCallbackValue: selectedItems [
	| domainCollection intersectingItems |
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
		callback: [ :value | self handleCallbackValue: value ]
]
