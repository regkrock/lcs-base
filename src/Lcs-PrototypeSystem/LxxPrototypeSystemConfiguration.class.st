Class {
	#name : #LxxPrototypeSystemConfiguration,
	#superclass : #LcsBaseConfiguration,
	#category : #'Lcs-PrototypeSystem-Base'
}

{ #category : #accessing }
LxxPrototypeSystemConfiguration >> parentSlotDefinition [
	<slotDefinition>
	^ LcsAcessorSlot new
		slotName: 'parent';
		yourself
]
