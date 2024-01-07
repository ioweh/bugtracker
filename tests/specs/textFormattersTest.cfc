//TextFormattersTest.cfc (TestBox test)
component extends="testbox.system.BaseSpec" {

    function beforeAll() {
        // Instantiate the TextFormatters component
        textFormatters = createObject("component", "bugtracker.text_formatters");
    }

    function run() {
        describe("Text Formatters Tests", function() {

            it("should return human-readable severity", function() {
                // Test with known severity values
                expect(textFormatters.getHumanReadableSeverity("blocker")).toBe("Blocker");
                expect(textFormatters.getHumanReadableSeverity("critical")).toBe("Critical");
                expect(textFormatters.getHumanReadableSeverity("non_critical")).toBe("Non-Critical");
                expect(textFormatters.getHumanReadableSeverity("request_for_change")).toBe("Request for Change");

                // Test with an unknown severity value
                expect(textFormatters.getHumanReadableSeverity("unknown")).toBe("Unknown");
            });

            it("should return human-readable urgency", function() {
                // Test with known urgency values
                expect(textFormatters.getHumanReadableUrgency("very_urgent")).toBe("Very Urgent");
                expect(textFormatters.getHumanReadableUrgency("urgent")).toBe("Urgent");
                expect(textFormatters.getHumanReadableUrgency("non_urgent")).toBe("Non-Urgent");
                expect(textFormatters.getHumanReadableUrgency("not_at_all_urgent")).toBe("Not at All Urgent");

                // Test with an unknown urgency value
                expect(textFormatters.getHumanReadableUrgency("unknown")).toBe("Unknown");
            });

            it("should capitalize the first letter", function() {
                // Test with various input values
                expect(textFormatters.capitalizeFirstLetter("hello")).toBe("Hello");
                expect(textFormatters.capitalizeFirstLetter("world")).toBe("World");
                expect(textFormatters.capitalizeFirstLetter("coldfusion")).toBe("Coldfusion");
                expect(textFormatters.capitalizeFirstLetter("testbox")).toBe("Testbox");

                // Test with an empty string
                expect(textFormatters.capitalizeFirstLetter("")).toBe("");
            });

        });
    }
}

