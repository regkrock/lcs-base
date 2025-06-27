Class {
	#name : #LcsBlockSlot,
	#superclass : #LcsSmalltalkObjectSlot,
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #defaults }
LcsBlockSlot >> defaultInitialValueBlock [
	^ nil
]

{ #category : #'as yet unclassified' }
LcsBlockSlot >> initialValueFor: aDomainObject [
	^ self initialValueBlock 
		ifNil: [ [ true ] ] 
		ifNotNil: [ self initialValueBlock ]
]

{ #category : #initialize }
LcsBlockSlot >> typeClass [
	^ BlockClosure.
]
