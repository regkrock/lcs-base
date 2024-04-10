Class {
	#name : #LcsDateSlot,
	#superclass : #LcsPrimitiveSlot,
	#category : #'Lcs-SlotDefinitions'
}

{ #category : #configuration }
LcsDateSlot >> typeClass [
	^ LcsSmalltalkConfiguration dateClass
]
