Class {
	#name : 'LuiMainForm',
	#superclass : 'LuiForm',
	#category : 'Lcs-WebComponents-Core',
	#package : 'Lcs-WebComponents',
	#tag : 'Core'
}

{ #category : 'defaults' }
LuiMainForm >> defaultComponentName [
	^ 'mainForm'
]

{ #category : 'defaults' }
LuiMainForm >> defaultCssClasses [
	^ OrderedCollection with: 'applicationArea'
]
