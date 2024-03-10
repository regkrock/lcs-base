Class {
	#name : #LxxPrototypeSystem,
	#superclass : #LcsBaseSystem,
	#category : #'Lcs-PrototypeSystem'
}

{ #category : #accessing }
LxxPrototypeSystem >> domainClasses [
	^OrderedCollection new
		add: LcsDomainObject;
		add: LcsBaseSystem;
		add: LcsModule;
		add: LcsBaseModule;
		add: self class;
		addAll: self moduleClasses;
		yourself
]

{ #category : #accessing }
LxxPrototypeSystem >> moduleClasses [
	^ OrderedCollection new
		add: LxxPrototype1Module;
		add: LxxPrototype2Module;
		yourself
]
