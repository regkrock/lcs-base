Class {
	#name : #LcsBlockSlot,
	#superclass : #LcsSmalltalkObjectSlot,
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #defaults }
LcsBlockSlot >> defaultInitialValueBlock [
	^ nil
]

{ #category : #'slot model' }
LcsBlockSlot >> initialValueFor: aDomainObject [
	^ self initialValueBlock 
		ifNil: [ [ true ] ] 
		ifNotNil: [ self initialValueBlock ]
]

{ #category : #configuration }
LcsBlockSlot >> typeClass [
	^ BlockClosure.
]
