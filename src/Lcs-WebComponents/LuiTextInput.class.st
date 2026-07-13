"
Tag type used: <input type=""text"" >  (WATextInputTag). Note the type=""text"" is the default so it is optional.


This is designed for entering a single line  vs a multi-line text. 
"
Class {
	#name : 'LuiTextInput',
	#superclass : 'LuiAbstractTextAreaComponent',
	#category : 'Lcs-WebComponents-Widgets',
	#package : 'Lcs-WebComponents',
	#tag : 'Widgets'
}

{ #category : 'initialize' }
LuiTextInput >> componentAttributesClass [
	^ LuiTextInputAttributes
]

{ #category : 'defaults' }
LuiTextInput >> defaultCssClasses [
	^ #( 'inputField' )
]

{ #category : 'defaults' }
LuiTextInput >> displayValue [
	^ self valueAccessor displayValue
]

{ #category : 'gt views' }
LuiTextInput >> gtViewTagName [
	^ super gtViewTagName , ' type=''text'''
]

{ #category : 'callbacks' }
LuiTextInput >> handleCallbackValue: value [ 
	self valueAccessor write: value
]

{ #category : 'initialize' }
LuiTextInput >> initializeNamed: aName [
	super initializeNamed: aName.
	self valueAccessor model: ''.
]

{ #category : 'initialize' }
LuiTextInput >> initializeOnSlot: aSlotDefinition model: aModel componentName: aString [
	super initializeOnSlot: aSlotDefinition model: aModel componentName: aString.
	aSlotDefinition propertyAt: 'title' ifPresent: [ :property | self title: property ]. 
	aSlotDefinition propertyAt: 'pattern' ifPresent: [ :property | self pattern: property ]. 
	self placeholder: aSlotDefinition label
]

{ #category : 'rendering' }
LuiTextInput >> renderComponentOn: html [
	| jQueryInstance |
	jQueryInstance := html jQuery this.
	html textInput
		addCommonAttributes: self;
		onChange: (
			(html jQuery ajax)
				callback: [ :value | self handleCallbackValue: value ] 
					value: (html jQuery id: self componentId) value ;
				onSuccess: ((html jQuery id: self componentId) load html: [ :h | h render: self "displayValue , 'xxxx' "]));
		value: self displayValue
		
	"	onChange: (jQueryInstance 
					callback: [ :value | self handleCallbackValue: value ]);
					load html: [ :h | 
			Transcript show: 'rerendering ' , self componentName , ' with: '  , self displayValue , ' On Change'; cr.
			h render: (self displayValue , ' On Change')]);
		onSuccess: _;"

]
