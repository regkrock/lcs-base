Class {
	#name : #LuiExperimentRoot,
	#superclass : #LuiRoot,
	#instVars : [
		'numtoconvert',
		'result'
	],
	#category : #'Lcs-WebComponentsTests-Experiment'
}

{ #category : #'as yet unclassified' }
LuiExperimentRoot class >> browserTabName [
	^ 'experiment'
]

{ #category : #register }
LuiExperimentRoot class >> initialize [
	WAAdmin register: self asApplicationAt: self browserTabName
]

{ #category : #'as yet unclassified' }
LuiExperimentRoot >> basicRenderResultOn [
	^ result displayString
]

{ #category : #'as yet unclassified' }
LuiExperimentRoot >> basicRenderResultOn: html [
	html render: result displayString
]

{ #category : #'as yet unclassified' }
LuiExperimentRoot >> convert [
	result := numtoconvert asNumber
]

{ #category : #'as yet unclassified' }
LuiExperimentRoot >> otherRenderingIdea [

				"onClick: (
					(html jQuery ajax)
						serializeForm;
						script: [:s | 
							self convert.
							s << ((s jQuery: 'convertResult')
									html: [:r | self basicRenderResultOn: r ] ) ] );"

]

{ #category : #'as yet unclassified' }
LuiExperimentRoot >> renderComponentOn: html [
	html
		form: [ html label with: 'Text to Convert:  '.
			html textInput
				id: #txtNumToConvert;
				onChange: (JSStream on: 'this.form.requestSubmit()');
				callback: [ :value | self setNumtoconvert: value ];
				value: numtoconvert.
			html space.
			html span: numtoconvert displayString.
			html break; break.
			html label with: 'Result:  '.
			html span id: 'convertedResult'; with: [ self basicRenderResultOn: html ].
			html break; break.
			(html button)
				id: 'convertButton';
				bePush;
				onClick: (
					(html jQuery id: 'convertedResult') load
						serializeForm;
						html: [ :r | 
							self convert.
							r render: result displayString ] );
				with: 'Convert' ]
]

{ #category : #'as yet unclassified' }
LuiExperimentRoot >> renderResultOn: html [
	html span
		id: 'convertResult';
		with: [ self basicRenderResultOn: html ]
]

{ #category : #'as yet unclassified' }
LuiExperimentRoot >> setNumtoconvert: value [ 
	numtoconvert := value
]

{ #category : #'as yet unclassified' }
LuiExperimentRoot >> updateRoot: anHtmlRoot [
	super updateRoot: anHtmlRoot.
	anHtmlRoot title: self class name greaseString
]
