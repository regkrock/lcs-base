Trait {
	#name : #LctDevScripterSuport,
	#category : #'Lcs-SlotToolsTests-Scripter'
}

{ #category : #'scripter - assertion' }
LctDevScripterSuport >> assert: aStep model: aModel acceptEnabled: isAcceptEnabled cancelEnabled: isCancelEnabled [
	| anAcceptId anCancelId |
	anAcceptId := GtMagritteActionElementId new
			description: aModel magritteAcceptAction.
	anCancelId := GtMagritteActionElementId new
			description: aModel magritteCancelAction.

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
