Class {
	#name : #LxxPrototypeOrganization,
	#superclass : #LcsDomainObject,
	#category : #'Lcs-PrototypeSystem'
}

{ #category : #'slot definition' }
LxxPrototypeOrganization class >> chiefExecutiveOfficerSlotDefinition [
	<slotDefinition>
	^ LcsMemberOfSlot new
		slotName: 'chiefExecutiveOfficer';
		collectionSlotName: 'persons';
		moduleName: LxxPrototypeSystem;
		beRequired;
		yourself
]

{ #category : #accessing }
LxxPrototypeOrganization >> chiefExecutiveOfficer [
	^ self getValueOfSlotNamed: 'chiefExecutiveOfficer'
]

{ #category : #accessing }
LxxPrototypeOrganization >> chiefExecutiveOfficer: aPerson [
	self setValueOfSlotNamed: 'chiefExecutiveOfficer' to: aPerson
]
