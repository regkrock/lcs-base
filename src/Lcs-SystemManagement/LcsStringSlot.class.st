Class {
	#name : #LcsStringSlot,
	#superclass : #LcsSmalltalkObjectSlot,
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #defaults }
LcsStringSlot >> defaultInitialValueBlock [
	^ [ :domainObject :slot | self typeClass new ]
]

{ #category : #'default ui component' }
LcsStringSlot >> defaultInputComponentClassName [
	^#LuiTextInput
]

{ #category : #iniitialize }
LcsStringSlot >> initialize [
	super initialize.
	self beAllowNil
]

{ #category : #'slot model' }
LcsStringSlot >> isNullObject: anObject [ 
	^ anObject isEmpty
]

{ #category : #configuration }
LcsStringSlot >> typeClass [
	<todo: 'This needs to use UTF-8 string calss'> 
	^ LcsSmalltalkConfiguration stringClass
]
