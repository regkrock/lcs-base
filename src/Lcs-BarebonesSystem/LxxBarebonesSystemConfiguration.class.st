Class {
	#name : #LxxBarebonesSystemConfiguration,
	#superclass : #LcsBaseConfiguration,
	#category : #'Lcs-BarebonesSystem'
}

{ #category : #accessing }
LxxBarebonesSystemConfiguration >> parentSlotDefinition [
	<slotDefinition>
	^ LcsSlotDefintion new
		slotName: 'parent';
		yourself
]
