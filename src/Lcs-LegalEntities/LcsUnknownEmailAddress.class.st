Class {
	#name : 'LcsUnknownEmailAddress',
	#superclass : 'LcsEmailAddress',
	#category : 'Lcs-LegalEntities',
	#package : 'Lcs-LegalEntities'
}

{ #category : 'instance creation' }
LcsUnknownEmailAddress class >> new [
	^ super new
]

{ #category : 'slot definitions' }
LcsUnknownEmailAddress class >> parentSlotDefinition [
	<slotDefinition>
	^ LcsParentSlot new
]
