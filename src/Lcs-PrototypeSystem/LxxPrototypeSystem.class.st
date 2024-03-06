Class {
	#name : #LxxPrototypeSystem,
	#superclass : #LcsBaseSystem,
	#category : #'Lcs-PrototypeSystem'
}

{ #category : #accessing }
LxxPrototypeSystem >> moduleClasses [
	^ OrderedCollection new
		add: LxxPrototype1Module;
		add: LxxTest2Module;
		yourself
]
