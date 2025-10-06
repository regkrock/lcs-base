Class {
	#name : #LcsStringSlot,
	#superclass : #LcsSmalltalkObjectSlot,
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #properties }
LcsStringSlot >> allowEmptyIntialValue [
	^ self propertyAt: 'allowEmptyIntialValue'
]

{ #category : #properties }
LcsStringSlot >> allowEmptyIntialValue: aBoolean [
	^ self propertyAt: 'allowEmptyIntialValue' put: aBoolean
]

{ #category : #'as yet unclassified' }
LcsStringSlot >> allowEmptyIntialValueDescription [
	<magritteDescription>
	^ MABooleanDescription new
		label: 'Allow Empty';
		priority: 10;
		accessor: #allowEmptyIntialValue;
		editorAptitude: [ BrGlamorousRegularEditorAptitude new glamorousFormEditorCodeFontAndSize ];
		labelAptitude: [ BrGlamorousLabelAptitude new glamorousFormLabelStyle ];
		beRequired
]

{ #category : #defaults }
LcsStringSlot >> defaultInitialValueBlock [
	^ [ :domainObject :slot | self typeClass new ]
]

{ #category : #'default ui component' }
LcsStringSlot >> defaultInputComponentClassName [
	^#LuiTextInput
]

{ #category : #properties }
LcsStringSlot >> initialValue: anObject [
	super initialValue:anObject printString
]

{ #category : #iniitialize }
LcsStringSlot >> initialize [
	super initialize.
	self allowEmptyIntialValue: true
]

{ #category : #testing }
LcsStringSlot >> isNullAllowed [
	^ self allowEmptyIntialValue
]

{ #category : #'slot model' }
LcsStringSlot >> isNullObject: anObject [ 
	^ anObject isString and: [ anObject isEmpty ]
]

{ #category : #configuration }
LcsStringSlot >> typeClass [
	<todo: 'This needs to use UTF-8 string calss'> 
	^ LcsSmalltalkConfiguration stringClass
]
