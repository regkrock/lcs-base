Class {
	#name : #LcsDateSlot,
	#superclass : #LcsPrimitiveSlot,
	#category : #'Lcs-SlotDefinitions'
}

{ #category : #accessing }
LcsDateSlot >> defaultInitialValue [ 
	^ Date today
]

{ #category : #configuration }
LcsDateSlot >> typeClass [
	^ LcsSmalltalkConfiguration dateClass
]
