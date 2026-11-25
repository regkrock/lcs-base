Class {
	#name : 'LcsUser',
	#superclass : 'LcsBaseUser',
	#instVars : [
		'person'
	],
	#category : 'Lcs-Security-Core',
	#package : 'Lcs-Security',
	#tag : 'Core'
}

{ #category : 'properties' }
LcsUser class >> fullNameSlotDefinition [
	<virtualSlotDefinition>
	^ LcsDelegatorSlot new
		slotName: 'fullName';
		addSlotType: String;
		targetSlotPath: #(#person #entityName);
		errorClass: MessageNotUnderstood;
		errorReturnObject: '';
		yourself
]

{ #category : 'slot definitions' }
LcsUser class >> personSlotDefinition [
	<accessorSlotDefinition>
	^ LcsPersonSlot new
		addSlotType: LcsPerson;
		addSlotType: LcsUnknownPerson;
		beAllowInitialNil;
		initialValueBlock: [ :parentDomainObject :slot | 
			| personClass |
			personClass := LcsObject classNamed: #LcsUnknownPerson.
			(personClass isNil or: [ personClass hasSlotModel not ]) 
				ifTrue: [ nil ]
				ifFalse: [ 
					LcsUnknownPerson new 
						parent: parentDomainObject; 
						yourself ] ];
		required: true;
		comment: 'When bootstrapping, the Legal Entitites module is not necessarily loaded. If not loaded or initialized, the person slot is set to nil. Otherwise it set to a new instance of LcsUnknownPerson'
		yourself
]

{ #category : 'accessing' }
LcsUser >> fullName [
	^ self slotVarNamed: 'fullName'
]

{ #category : 'accessing' }
LcsUser >> fullName: anObject [
	self slotVarNamed: 'fullName' put: anObject
]

{ #category : 'accessing' }
LcsUser >> person [
	^ self slotVarNamed: 'person'
]

{ #category : 'accessing' }
LcsUser >> person: anObject [
	self slotVarNamed: 'person' put: anObject
]
