Class {
	#name : #LxxPrototypeSystemConfiguration,
	#superclass : #LcsBaseConfiguration,
	#category : #'Lcs-PrototypeSystem-Base'
}

{ #category : #accessing }
LxxPrototypeSystemConfiguration >> parentSlotDefinition [
	<slotDefinition>
	^ LcsSlotDefinition new
		slotName: 'parent';
		yourself
]
