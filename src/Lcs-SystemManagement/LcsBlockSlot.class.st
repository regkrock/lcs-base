Class {
	#name : #LcsBlockSlot,
	#superclass : #LcsSmalltalkObjectSlot,
	#category : #'Lcs-SystemManagement-Slot'
}

{ #category : #'slot model' }
LcsBlockSlot >> _initialValueFor: aDomainObject [
	^ self initialValueBlock 
		ifNil: [ [ true ] ] 
		ifNotNil: [ self initialValueBlock ]
]

{ #category : #defaults }
LcsBlockSlot >> defaultInitialValueBlock [
	^ nil
]

{ #category : #configuration }
LcsBlockSlot >> typeClass [
	^ BlockClosure.
]
