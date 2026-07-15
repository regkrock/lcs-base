Class {
	#name : 'LuiCheckbox',
	#superclass : 'LuiFormInputComponent',
	#category : 'Lcs-WebComponents-Widgets',
	#package : 'Lcs-WebComponents',
	#tag : 'Widgets'
}

{ #category : 'rendering' }
LuiCheckbox >> contentsAsString [
	^ self toStringConverter convertToString: self valueAccessor contents
]

{ #category : 'gt views' }
LuiCheckbox >> gtViewTagName [
	^ super gtViewTagName , ' type=''checkbox'''
]

{ #category : 'callbacks' }
LuiCheckbox >> handleCallbackValue: value [ 
	self valueAccessor write: (self fromStringConverter convertFromString: value)
]

{ #category : 'initialize' }
LuiCheckbox >> initialize [
	super initialize.
	self toStringConverter: LuiBooleanToStringConverter new.
	self fromStringConverter: LuiStringToBooleanConverter new.
]

{ #category : 'rendering' }
LuiCheckbox >> isChecked [
	^ self valueAccessor contents == true or: [ self valueAccessor contents = 'on' ]
]

{ #category : 'rendering' }
LuiCheckbox >> renderComponentOn: html [
	html checkbox
		addCommonAttributes: self;
		onChange: (self handleCallbackAndRenderDependents: html);
		value: self valueAccessor contents == true
]
