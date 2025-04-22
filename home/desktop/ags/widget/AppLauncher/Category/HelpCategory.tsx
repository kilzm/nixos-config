import Category from "./Category";

function HelpCategory() {
    const help = <box vertical name={"help"}>
        <box vertical cssClasses={["help"]}>
            <label label={`?    Show the help.`} halign={START} />
            <label label={`>    Run a shell command.`} halign={START} />
            <label label={`=    Perform calculations.`} halign={START} />
            <label label={`.     Search Google.`} halign={START} />
        </box>
    </box>

    return <Category 
        name={"Help"}
        action={() => {}}
        child={help}
    />
}

export default HelpCategory
