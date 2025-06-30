Class {
	#name : #LcsBasePostCode,
	#superclass : #LcsDomainObject,
	#instVars : [
		'code'
	],
	#category : #'Lcs-Geography-Domain'
}

{ #category : #'slot definitions' }
LcsBasePostCode class >> codeSlotDefinition [
	<slotDefinition>
	^ LcsStringSlot new
		slotName: 'code';
		required: true;
		slotTypes: (OrderedCollection with: String);
		initialValueBlock: '[ self typeClass new ]';
		yourself
]

{ #category : #accessing }
LcsBasePostCode >> code [
	^ self slotVarNamed: 'code'
]

{ #category : #accessing }
LcsBasePostCode >> code: anObject [
	self slotVarNamed: 'code' put: anObject
]
