"
This is a system with no modules, etc. It is used for basic testing of the system logic
"
Class {
	#name : #LxxBarebonesSystem,
	#superclass : #LcsBaseSystem,
	#instVars : [
		'persons'
	],
	#category : #'Lcs-PrototypeSystem'
}

{ #category : #accessing }
LxxBarebonesSystem class >> personsSlotDefinition [
	<slotDefinition>
	^LcsGlobalCollectionSlotDefinition new
		slotName: 'persons';
		beIdentitySetCollection;
		yourself
]

{ #category : #accessing }
LxxBarebonesSystem >> domainClasses [
	^OrderedCollection new
		add: LcsDomainObject;
		add: LcsBaseSystem;
		add: LcsModule;
		add: LxxBarebonesSystem;
		add: LxxPerson;
		yourself
]

{ #category : #accessing }
LxxBarebonesSystem >> persons [
	^ self getValueOfSlotNamed: 'persons'
]

{ #category : #accessing }
LxxBarebonesSystem >> persons: anObject [
	self setValueOfSlotNamed: 'presons' to: anObject
]
