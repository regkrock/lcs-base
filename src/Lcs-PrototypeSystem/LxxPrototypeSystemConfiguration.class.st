Class {
	#name : #LxxPrototypeSystemConfiguration,
	#superclass : #LcsBaseConfiguration,
	#category : #'Lcs-PrototypeSystem-Base'
}

{ #category : #accessing }
LxxPrototypeSystemConfiguration >> parentSlotDefinition [
	<slotDefinition>
	^ LcsAccessorSlot new
		slotName: 'parent';
		yourself
]
