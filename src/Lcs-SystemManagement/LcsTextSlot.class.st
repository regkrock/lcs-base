Class {
	#name : 'LcsTextSlot',
	#superclass : 'LcsStringSlot',
	#category : 'Lcs-SystemManagement-Slot',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slot'
}

{ #category : 'initialize' }
LcsTextSlot >> initialize [
	super initialize.
	self prevalidationTransformBlock: [ :value :slot | 
		value isString ifTrue: [ value asText ] ifFalse: [ value ] ]
]

{ #category : 'defaults' }
LcsTextSlot >> typeClass [
	<todo: 'This needs to use UTF-8 string calss'> 
	^ LcsSmalltalkConfiguration textClass
]
