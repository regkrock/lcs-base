Class {
	#name : 'LuiAbstractTextAreaComponent',
	#superclass : 'LuiFormInputComponent',
	#category : 'Lcs-WebComponents-Widgets',
	#package : 'Lcs-WebComponents',
	#tag : 'Widgets'
}

{ #category : 'testing' }
LuiAbstractTextAreaComponent class >> isAbstract [ 
	^ self == LuiAbstractTextAreaComponent
]

{ #category : 'attributes - accessing' }
LuiAbstractTextAreaComponent >> autocomplete [
	^ self attributes autocomplete
]

{ #category : 'attributes - accessing' }
LuiAbstractTextAreaComponent >> autocomplete: aString [
	^ self attributes autocomplete: aString
]

{ #category : 'attributes - commands' }
LuiAbstractTextAreaComponent >> beNoAutocomplete [
	self autocomplete: nil
]

{ #category : 'initialize' }
LuiAbstractTextAreaComponent >> componentAttributesClass [
	^ LuiAbstractTextAreaAttributes
]

{ #category : 'attributes - accessing' }
LuiAbstractTextAreaComponent >> placeholder [
	^ self attributes placeholder
]

{ #category : 'attributes - accessing' }
LuiAbstractTextAreaComponent >> placeholder: aString [
	^ self attributes placeholder: aString
]
