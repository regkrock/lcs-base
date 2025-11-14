Class {
	#name : #LcsSecurityRole,
	#superclass : #LcsDomainObject,
	#instVars : [
		'role'
	],
	#category : #'Lcs-Security-Core'
}

{ #category : #'slot definitions' }
LcsSecurityRole class >> parentSlotDefinition [
	<slotDefinition>
	^ LcsGlobalCollectionReferenceSlot new
			slotTypes: (OrderedCollection with: LcsSecurityRoles);
			slotName: 'parent';
			collectionSlotName: 'securityRoles';
			collectionSlotModuleName: 'Security Module';
			yourself
]

{ #category : #'slot definitions' }
LcsSecurityRole class >> roleSlotDefinition [
	<slotDefinition>
	^ LcsStringSlot new
		slotName: 'role';
		required: true;
		allowEmptyIntialValue;
		yourself
]

{ #category : #accessing }
LcsSecurityRole >> role [
	^ self slotVarNamed: 'role'
]

{ #category : #accessing }
LcsSecurityRole >> role: anObject [
	self slotVarNamed: 'role' put: anObject
]
