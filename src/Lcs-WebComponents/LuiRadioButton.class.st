Class {
	#name : 'LuiRadioButton',
	#superclass : 'LuiModelWidget',
	#category : 'Lcs-WebComponents-Widgets',
	#package : 'Lcs-WebComponents',
	#tag : 'Widgets'
}

{ #category : 'initialize' }
LuiRadioButton >> componentAttributesClass [
	^ LuiFormInputAttributes
]

{ #category : 'callbacks' }
LuiRadioButton >> handleCallbackValue: value [ 
	self parentComponent valueAccessor write: self valueAccessor model
]

{ #category : 'attributes' }
LuiRadioButton >> name: aString [
	self attributes name: aString
]

{ #category : 'composition' }
LuiRadioButton >> postAddToParent [
	self addDependentComponent: self parentComponent.
	self valueAccessor readSelector: #yourself.
	self name: self parentComponent componentName.
	self text: (
		self valueAccessor slotDefinition optionValueBlock
			cull: self valueAccessor model
			cull: self valueAccessor slotDefinition)
]

{ #category : 'rendering' }
LuiRadioButton >> renderComponentOn: html [
	html radioButton
		addCommonAttributes: self;
		onChange: (self handleCallbackAndRenderDependents: html);
		checked: (self parentComponent valueAccessor read = self valueAccessor read);
		value: self text
]
