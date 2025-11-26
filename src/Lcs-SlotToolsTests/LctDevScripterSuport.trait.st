Trait {
	#name : 'LctDevScripterSuport',
	#category : 'Lcs-SlotToolsTests-Scripter',
	#package : 'Lcs-SlotToolsTests',
	#tag : 'Scripter'
}

{ #category : 'asking' }
LctDevScripterSuport >> actionIdFor: aDescriptionSymbol [
	^ GtMagritteActionElementId new description: (self subjectScripter model perform: aDescriptionSymbol)
]

{ #category : 'scripter - assertion' }
LctDevScripterSuport >> assert: aStep acceptEnabled: isAcceptEnabled cancelEnabled: isCancelEnabled acceptId: anAcceptId cancelId: anCancelId [
	aStep
		assertStep: [ :s | 
			s
				label: 'Assert accept button enablement';
				value: [ :aButton | aButton isEnabled ]
					equals: [ :aButton | isAcceptEnabled ];
				// anAcceptId ].

	isCancelEnabled
		ifNotNil: [ aStep
				assertStep: [ :s | 
					s
						label: 'Assert cancel button enablement';
						value: [ :aButton | aButton isEnabled ]
							equals: [ :aButton | isCancelEnabled ];
						// anCancelId ] ]
		ifNil: [ aStep
				assertStep: [ :s | 
					s
						label: 'Assert cancel button is missing';
						value: [ :anElement | 
								| aQuery |
								aQuery := anElement query // anCancelId.
								aQuery result size ]
							equals: [ 0 ] ] ]
]

{ #category : 'scripter - assertion' }
LctDevScripterSuport >> assert: aStep acceptEnabled: isAcceptEnabled cancelEnabled: isCancelEnabled buildEnabled: isBuildEnabled acceptId: anAcceptId cancelId: anCancelId buildId: aBuildId [
	aStep
		assertStep: [ :s | 
			s
				label: 'Assert accept button enablement';
				value: [ :aButton | aButton isEnabled ]
					equals: [ :aButton | isAcceptEnabled ];
				// anAcceptId ].

	isCancelEnabled
		ifNotNil: [ aStep
				assertStep: [ :s | 
					s
						label: 'Assert cancel button enablement';
						value: [ :aButton | aButton isEnabled ]
							equals: [ :aButton | isCancelEnabled ];
						// anCancelId ] ]
		ifNil: [ aStep
				assertStep: [ :s | 
					s
						label: 'Assert cancel button is missing';
						value: [ :anElement | 
								| aQuery |
								aQuery := anElement query // anCancelId.
								aQuery result size ]
							equals: [ 0 ] ] ].
							
	isBuildEnabled 
		ifNotNil: [ aStep
				assertStep: [ :s | 
					s
						label: 'Assert build button enablement';
						value: [ :aButton | aButton isEnabled ]
							equals: [ :aButton | isBuildEnabled ];
						// aBuildId ] ]
		ifNil: [ aStep
				assertStep: [ :s | 
					s
						label: 'Assert build button is missing';
						value: [ :anElement | 
								| aQuery |
								aQuery := anElement query // aBuildId.
								aQuery result size ]
							equals: [ 0 ] ] ].

]

{ #category : 'scripter - assertion' }
LctDevScripterSuport >> assert: aStep model: aModel acceptEnabled: isAcceptEnabled cancelEnabled: isCancelEnabled [
	| anAcceptId anCancelId |
	anAcceptId := GtMagritteActionElementId new
			description: aModel magritteAcceptAction.
	anCancelId := GtMagritteActionElementId new
			description: aModel magritteCancelAction.
	self
		assert: aStep
		acceptEnabled: isAcceptEnabled
		cancelEnabled: isCancelEnabled
		acceptId: anAcceptId
		cancelId: anCancelId
]

{ #category : 'scripter - assertion' }
LctDevScripterSuport >> assert: aStep model: aModel acceptEnabled: isAcceptEnabled cancelEnabled: isCancelEnabled buildEnabled: isBuildEnabled [
	| anAcceptId aCancelId aBuildId |
	anAcceptId := GtMagritteActionElementId new description: aModel magritteAcceptAction.
	aCancelId := GtMagritteActionElementId new description: aModel magritteCancelAction.
	aBuildId := GtMagritteActionElementId new description: aModel magritteBuildAction.
	self
		assert: aStep
		acceptEnabled: isAcceptEnabled
		cancelEnabled: isCancelEnabled
		buildEnabled: isBuildEnabled
		acceptId: anAcceptId
		cancelId: aCancelId
		buildId: aBuildId
]

{ #category : 'private' }
LctDevScripterSuport >> cackeKeyOf: aDescriptionSymbol [
	^ self subjectScripterMemento cache
		at: (self targetDescriptionFor: aDescriptionSymbol)
]

{ #category : 'scripter - assertion' }
LctDevScripterSuport >> clickOn: anId [
	self subjectScripter
		substeps: ('Click on an element: ' , anId asSymbol)
		do: [ :aStep | 

			aStep requestFocus
				// anId;
				play.

			aStep
				clickStep: [ :s | 
					s
						// anId;
						onChildAt: 1 ] ]
]

{ #category : 'asking' }
LctDevScripterSuport >> currentValueOf: aDescriptionSymbol [
	^ (self cackeKeyOf: aDescriptionSymbol)
		ifSome: [ :item | item value currentValue ]
		ifNone: [ nil ]
]

{ #category : 'asking' }
LctDevScripterSuport >> fieldIdFor: aDescriptionSymbol [
	^ GtMagritteFieldElementId new description: (self subjectScripter model perform: aDescriptionSymbol)
]

{ #category : 'asking' }
LctDevScripterSuport >> previousValueOf: aDescriptionSymbol [
	^ (self cackeKeyOf: aDescriptionSymbol)
		ifSome: [ :item | item value originalValue ]
		ifNone: [ nil ]
]

{ #category : 'accessing' }
LctDevScripterSuport >> subjectScripter [
	^ self subject
]

{ #category : 'accessing' }
LctDevScripterSuport >> subjectScripter: aScripter [
	self subject: aScripter
]

{ #category : 'scripter - model' }
LctDevScripterSuport >> subjectScripterMemento [
	^self subjectScripter element userData at: GtMagritteViewModel gtMementoSymbol
]

{ #category : 'scripter - model' }
LctDevScripterSuport >> subjectScripterModel [
	^ self subjectScripter model
]

{ #category : 'asking' }
LctDevScripterSuport >> targetDescriptionFor: aDescriptionSymbol [
	| keys descriptionLabel |
	keys := self subjectScripterMemento cache keys.
	descriptionLabel := (self subjectScripter model perform: aDescriptionSymbol) label.
	^ keys detect: [ :each | each label = descriptionLabel ] ifNone: [ ^nil ].
]

{ #category : 'scripter - assertion' }
LctDevScripterSuport >> validateEntryOf: aString into: anId resultingAccept: anAcceptBoolean cancel: aCancelBoolean [
	self subjectScripter
		substeps: 'Enter slot class name'
		do: [ :aStep | 

			aStep requestFocus
				// anId;
				play.

			aStep
				typeStep: [ :s | 
					s
						text: aString;
						// anId ].
						
			self
				assert: aStep
				model: self subjectScripter model
				acceptEnabled: anAcceptBoolean
				cancelEnabled: aCancelBoolean ].

]
