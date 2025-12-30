Class {
	#name : 'LcsSecurityRole',
	#superclass : 'LcsDomainObject',
	#instVars : [
		'role'
	],
	#category : 'Lcs-Security-Core',
	#package : 'Lcs-Security',
	#tag : 'Core'
}

{ #category : 'slot definitions' }
LcsSecurityRole class >> parentSlotDefinition [
	<accessorSlotDefinition>
	^ LcsGlobalCollectionReferenceSlot new
		slotTypes: (OrderedCollection with: LcsSecurityRoles);
		slotName: 'parent';
		collectionSlotName: 'securityRoles';
		collectionSlotModuleName: LcsSecurityModule defaultModuleName;
		yourself
]

{ #category : 'slot definitions' }
LcsSecurityRole class >> roleSlotDefinition [
	<accessorSlotDefinition>
	^ LcsStringSlot new
		slotName: 'role';
		required: true;
		allowEmptyIntialValue;
		yourself
]

{ #category : 'accessing' }
LcsSecurityRole >> role [
	^ self slotVarNamed: 'role'
]

{ #category : 'accessing' }
LcsSecurityRole >> role: anObject [
	self slotVarNamed: 'role' put: anObject
]
