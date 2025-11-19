Class {
	#name : 'LcsApplicationEnvironmentViewItem',
	#superclass : 'LcsViewItem',
	#instVars : [
		'context'
	],
	#category : 'Lcs-SystemManagement-View',
	#package : 'Lcs-SystemManagement',
	#tag : 'View'
}

{ #category : 'defaults' }
LcsApplicationEnvironmentViewItem class >> defaultChildrenSelector [
	^ #applicationEnvironmentViewChildren
]

{ #category : 'instance creation' }
LcsApplicationEnvironmentViewItem class >> newOn: anObject label: aLabel item: anItem [ 
	^ self new
		initializeOn: anObject label: aLabel item: anItem;
		yourself
]

{ #category : 'gt views' }
LcsApplicationEnvironmentViewItem >> activateSuspendSystemButton [
	^ BrButton new
		aptitude: BrGlamorousButtonWithLabelAptitude new;
		label: self item toggleActionButtonLabel;
		action: [ :aButton | 
			self item toggleStatus.
			aButton phlow fireViewUpdateWish ]
]

{ #category : 'accessing' }
LcsApplicationEnvironmentViewItem >> context [
	^ context
]

{ #category : 'accessing' }
LcsApplicationEnvironmentViewItem >> context: anObject [ 
	context := anObject
]

{ #category : 'gt views' }
LcsApplicationEnvironmentViewItem >> debugSystemButton [
	^ BrButton new
		aptitude: BrGlamorousButtonWithLabelAptitude new;
		icon: BrGlamorousVectorIcons debug;
		label: 'Debug';
		action: [ :aButton | 
			RubSmalltalkEditor new
				textArea: (RubEditingArea new
								editingMode: RubSmalltalkCodeMode new;
								yourself);
				debug: (ReadStream on: 'self item new') ]
]

{ #category : 'gt views' }
LcsApplicationEnvironmentViewItem >> initializeOn: anObject label: aLabel item: anItem [ 
	self
		context: anObject;
		label: aLabel;
		item: anItem
]

{ #category : 'gt views' }
LcsApplicationEnvironmentViewItem >> isInstantiatedSystem [
	(self item respondsTo: #isApplicationSystem) ifFalse: [ ^ false ].
	^ self item isApplicationSystem
]

{ #category : 'testing' }
LcsApplicationEnvironmentViewItem >> isSystemClass [
	self item isClass ifFalse: [ ^ false ].
	^self item isApplicationSystemClass
]

{ #category : 'accessing' }
LcsApplicationEnvironmentViewItem >> itemChildren: anItemChildrenSelector [
	self label = 'Available Systems'
		ifTrue: [ 
			^ self context applicationEnvironmentViewaAvailableSystemsChildren ].
	^ super itemChildren: anItemChildrenSelector
]

{ #category : 'gt views' }
LcsApplicationEnvironmentViewItem >> startNewSystemButton [
	^ BrButton new
		aptitude: BrGlamorousButtonWithLabelAptitude new;
		label: 'Start';
		action: [ :aButton | self item new ]
]

{ #category : 'gt views' }
LcsApplicationEnvironmentViewItem >> startStopApplicationEnvironmentButton [
	^ self item == true
		ifTrue: [ BrButton new
				aptitude: BrGlamorousButtonWithLabelAptitude new;
				label: 'Stop';
				action: [ :aButton | LcsApplicationEnvironment releaseApplicationEnvironment ] ]
		ifFalse: [ BrButton new
				aptitude: BrGlamorousButtonWithLabelAptitude new;
				label: 'Start';
				action: [ :aButton | LcsApplicationEnvironment initializeApplicationEnvironment ] ]
]

{ #category : 'gt views' }
LcsApplicationEnvironmentViewItem >> startSuspendSystemButton [
	self isSystemClass ifTrue: [ ^ self startSystemButton ].
	self isInstantiatedSystem ifTrue: [ ^ self activateSuspendSystemButton ].

	^ BrButton new
]

{ #category : 'gt views' }
LcsApplicationEnvironmentViewItem >> startSystemButton [
	^ BrButton new
		aptitude: BrGlamorousButtonWithLabelAptitude new;
		label: 'Start';
		action: [ :aButton | 
			self item new.
			aButton phlow fireViewUpdateWish ]
]

{ #category : 'gt views' }
LcsApplicationEnvironmentViewItem >> stopButton [
	self isInstantiatedSystem ifTrue: [ ^ self stopSystemButton ].
	^ BrButton new
]

{ #category : 'gt views' }
LcsApplicationEnvironmentViewItem >> stopSystemButton [
	^ BrButton new
		aptitude: BrGlamorousButtonWithLabelAptitude new;
		label: 'Stop';
		action: [ :aButton | 
			self item removeSystem.
			aButton phlow fireViewUpdateWish ]
]
